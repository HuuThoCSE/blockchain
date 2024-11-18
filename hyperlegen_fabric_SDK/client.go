package main

import (
	"fmt"
	"log"
	"path/filepath"

	"github.com/hyperledger/fabric-sdk-go/pkg/core/config"
	"github.com/hyperledger/fabric-sdk-go/pkg/gateway"
)

func main() {
	// Đường dẫn tới ví và cấu hình kết nối
	walletPath := "./wallet"
	connectionProfile := "./connection-profile.yaml"

	// Tạo ví cho người dùng
	wallet, err := gateway.NewFileSystemWallet(walletPath)
	if err != nil {
		log.Fatalf("Không thể tạo ví: %v", err)
	}

	// Kiểm tra xem đã có người dùng 'appUser' trong ví chưa
	if !wallet.Exists("appUser") {
		log.Fatalf("Người dùng 'appUser' chưa được đăng ký.")
	}

	// Kết nối với Gateway
	gw, err := gateway.Connect(
		gateway.WithConfig(config.FromFile(filepath.Clean(connectionProfile))),
		gateway.WithIdentity(wallet, "appUser"),
	)
	if err != nil {
		log.Fatalf("Không thể kết nối với Gateway: %v", err)
	}
	defer gw.Close()

	// Lấy thông tin kênh và contract
	network, err := gw.GetNetwork("mychannel")
	if err != nil {
		log.Fatalf("Không thể lấy thông tin kênh: %v", err)
	}

	contract := network.GetContract("mychaincode")

	// Thực hiện giao dịch 'ThemSanpham' để thêm sản phẩm mới
	_, err = contract.SubmitTransaction("ThemSanpham", "TH5678", "Pepsi", "20", "18000")
	if err != nil {
		log.Fatalf("Không thể thực hiện giao dịch: %v", err)
	}
	fmt.Println("Giao dịch thêm sản phẩm thành công!")

	// Thực hiện truy vấn 'DocSanpham' để lấy thông tin sản phẩm
	result, err := contract.EvaluateTransaction("DocSanpham", "TH5678")
	if err != nil {
		log.Fatalf("Không thể thực hiện truy vấn: %v", err)
	}
	fmt.Printf("Thông tin sản phẩm: %s\n", string(result))
}
