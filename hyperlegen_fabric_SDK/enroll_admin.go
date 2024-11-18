package main

import (
	"log"
	"path/filepath"

	"github.com/hyperledger/fabric-sdk-go/pkg/client/msp"
	"github.com/hyperledger/fabric-sdk-go/pkg/core/config"
	"github.com/hyperledger/fabric-sdk-go/pkg/fabsdk"
	"github.com/hyperledger/fabric-sdk-go/pkg/gateway"
)

func main() {
	connectionProfile := "./connection-profile.yml"

	// Tạo SDK
	sdk, err := fabsdk.New(config.FromFile(filepath.Clean(connectionProfile)))
	if err != nil {
		log.Fatalf("Không thể tạo SDK: %v", err)
	}
	defer sdk.Close()

	// Tạo client MSP cho CA Admin
	mspClient, err := msp.New(sdk.Context())
	if err != nil {
		log.Fatalf("Không thể tạo client MSP: %v", err)
	}

	// Enroll admin user với CA
	err = mspClient.Enroll("admin", msp.WithSecret("adminpw"))
	if err != nil {
		log.Fatalf("Lỗi khi enroll admin: %v", err)
	}

	// Lấy thông tin SigningIdentity cho admin
	signingIdentity, err := mspClient.GetSigningIdentity("admin")
	if err != nil {
		log.Fatalf("Lỗi khi lấy SigningIdentity cho admin: %v", err)
	}

	// Lấy khóa bí mật từ SigningIdentity
	privateKeyBytes, err := signingIdentity.PrivateKey().Bytes()
	if err != nil {
		log.Fatalf("Lỗi khi lấy khóa bí mật của admin: %v", err)
	}

	// Lưu thông tin admin vào ví
	wallet, err := gateway.NewFileSystemWallet("./wallet")
	if err != nil {
		log.Fatalf("Không thể tạo ví: %v", err)
	}

	// Kiểm tra xem admin đã tồn tại trong ví chưa
	exists := wallet.Exists("admin")
	if exists {
		log.Println("Admin đã tồn tại trong ví.")
		return
	}

	// Tạo X509Identity từ SigningIdentity
	identity := gateway.NewX509Identity(
		"Org1MSP",
		string(signingIdentity.EnrollmentCertificate()),
		string(privateKeyBytes),
	)

	err = wallet.Put("admin", identity)
	if err != nil {
		log.Fatalf("Lỗi khi lưu admin vào ví: %v", err)
	}

	log.Println("Admin đã được enroll và lưu vào ví thành công")
}
