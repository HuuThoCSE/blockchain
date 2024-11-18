package main

import (
	"fmt"
	"log"

	"github.com/hyperledger/fabric-sdk-go/pkg/client/msp"
	"github.com/hyperledger/fabric-sdk-go/pkg/core/config"
	"github.com/hyperledger/fabric-sdk-go/pkg/fabsdk"
	"github.com/hyperledger/fabric-sdk-go/pkg/gateway"
)

func main() {
	// Đường dẫn đến tệp cấu hình connection-profile.yml
	ccpPath := "./connection-profile.yml"

	// Tạo ví để lưu trữ danh tính người dùng
	wallet, err := gateway.NewFileSystemWallet("./wallet")
	if err != nil {
		log.Fatalf("Không thể tạo ví: %v", err)
	}

	// Kiểm tra xem 'admin' đã tồn tại trong ví chưa
	exists := wallet.Exists("admin")
	if !exists {
		log.Fatalf("Người dùng 'admin' chưa được enroll. Vui lòng enroll 'admin' trước.")
	}

	// Kiểm tra xem 'appUser' đã tồn tại trong ví chưa
	exists = wallet.Exists("appUser")
	if exists {
		fmt.Println("Người dùng 'appUser' đã tồn tại trong ví.")
		return
	}

	// Khởi tạo SDK
	sdk, err := fabsdk.New(config.FromFile(ccpPath))
	if err != nil {
		log.Fatalf("Không thể khởi tạo SDK: %v", err)
	}
	defer sdk.Close()

	// Tạo client MSP với người dùng 'admin'
	mspClient, err := msp.New(sdk.Context())
	if err != nil {
		log.Fatalf("Không thể tạo MSP client: %v", err)
	}

	// Đăng ký người dùng 'appUser'
	enrollmentID := "appUser"
	affiliation := "org1.department1"

	secret, err := mspClient.Register(&msp.RegistrationRequest{
		Name:        enrollmentID,
		Affiliation: affiliation,
		Type:        "client",
	})
	if err != nil {
		log.Fatalf("Không thể đăng ký người dùng 'appUser': %v", err)
	}

	// Enroll người dùng 'appUser'
	err = mspClient.Enroll(enrollmentID, msp.WithSecret(secret))
	if err != nil {
		log.Fatalf("Không thể enroll người dùng 'appUser': %v", err)
	}

	// Lấy danh tính đăng nhập của người dùng 'appUser'
	signingIdentity, err := mspClient.GetSigningIdentity(enrollmentID)
	if err != nil {
		log.Fatalf("Không thể lấy danh tính đăng nhập của 'appUser': %v", err)
	}

	// Lấy chứng chỉ dưới dạng PEM
	certPEM := signingIdentity.EnrollmentCertificate()

	// Lấy khóa riêng
	privateKey, err := signingIdentity.PrivateKey().Bytes()
	if err != nil {
		log.Fatalf("Không thể lấy bytes của khóa riêng: %v", err)
	}

	// Tạo X509Identity cho 'appUser'
	identity := gateway.NewX509Identity(
		"Org1MSP",
		string(certPEM),
		string(privateKey),
	)

	// Lưu 'appUser' vào ví
	err = wallet.Put(enrollmentID, identity)
	if err != nil {
		log.Fatalf("Lỗi khi lưu 'appUser' vào ví: %v", err)
	}

	log.Println("Người dùng 'appUser' đã được đăng ký và enroll thành công")
}
