package main

import (
	"fmt"
	"log"

	"github.com/hyperledger/fabric-sdk-go/pkg/core/config"
	"github.com/hyperledger/fabric-sdk-go/pkg/gateway"
)

func main() {
	// Đường dẫn đến file connection-profile.yml
	ccpPath := "./connection-profile.yml"

	// Tạo ví người dùng (wallet) để lưu danh tính
	wallet, err := gateway.NewFileSystemWallet("wallet")
	if err != nil {
		log.Fatalf("Không thể tạo ví: %v", err)
	}

	// Kiểm tra nếu người dùng 'appUser' đã được đăng ký trong ví
	if !wallet.Exists("appUser") {
		fmt.Println("Người dùng 'appUser' chưa được đăng ký. Vui lòng đăng ký trước khi thực hiện giao dịch.")
		return
	}

	// Kết nối tới gateway (cổng kết nối) với danh tính của 'appUser'
	gw, err := gateway.Connect(
		gateway.WithConfig(config.FromFile(ccpPath)), // Đọc cấu hình từ file connection-profile.yml
		gateway.WithIdentity(wallet, "appUser"),      // Sử dụng danh tính 'appUser'
	)
	if err != nil {
		log.Fatalf("Không thể kết nối tới gateway: %v", err)
	}
	defer gw.Close() // Đảm bảo đóng gateway sau khi hoàn tất

	// Kết nối tới kênh 'mychannel'
	network, err := gw.GetNetwork("mychannel")
	if err != nil {
		log.Fatalf("Không thể lấy kênh: %v. Hãy kiểm tra cấu hình kênh và kết nối với peer.", err)
	}

	// Lấy chaincode 'mychaincode'
	contract := network.GetContract("mychaincode")

	// Thực hiện giao dịch để đọc tất cả sản phẩm
	fmt.Println("Đọc tất cả sản phẩm từ blockchain...")
	result, err := contract.EvaluateTransaction("DocTatCaSanpham") // Gọi hàm "DocTatCaSanpham"
	if err != nil {
		log.Fatalf("Thực thi giao dịch thất bại: %v. Hãy kiểm tra hàm DocTatCaSanpham trong chaincode.", err)
	}

	// In kết quả trả về
	fmt.Println("Kết quả đọc tất cả sản phẩm:", string(result))
}
