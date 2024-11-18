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
	connectionProfile := "./connection-profile.yaml"

	// Tạo SDK
	sdk, err := fabsdk.New(config.FromFile(filepath.Clean(connectionProfile)))
	if err != nil {
		log.Fatalf("Không thể tạo SDK: %v", err)
	}
	defer sdk.Close()

	// Tạo client MSP với admin
	adminClient, err := msp.New(sdk.Context(fabsdk.WithUser("admin")))
	if err != nil {
		log.Fatalf("Không thể tạo admin client MSP: %v", err)
	}

	// Đăng ký người dùng 'appUser'
	registrationRequest := &msp.RegistrationRequest{
		Name:        "appUser",
		Affiliation: "org1.department1",
	}
	enrollmentSecret, err := adminClient.Register(registrationRequest)
	if err != nil {
		log.Fatalf("Lỗi khi đăng ký người dùng: %v", err)
	}

	// Enroll người dùng 'appUser'
	userClient, err := msp.New(sdk.Context())
	if err != nil {
		log.Fatalf("Không thể tạo client MSP: %v", err)
	}

	err = userClient.Enroll("appUser", msp.WithSecret(enrollmentSecret))
	if err != nil {
		log.Fatalf("Lỗi khi enroll người dùng 'appUser': %v", err)
	}

	// Đưa 'appUser' vào ví
	wallet, err := gateway.NewFileSystemWallet("./wallet")
	if err != nil {
		log.Fatalf("Không thể tạo ví: %v", err)
	}

	identity, err := gateway.NewX509Identity("Org1MSP", userClient.GetEnrollment().Identity().Cert(), userClient.GetEnrollment().Identity().PrivateKey())
	if err != nil {
		log.Fatalf("Lỗi khi tạo identity cho 'appUser': %v", err)
	}

	wallet.Put("appUser", identity)
}
