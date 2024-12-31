package main
import (
	"encoding/json" // Thư viện xử lý JSON
	"fmt" // Thư viện xử lý chuỗi
	"strconv" // Thư viện xử lý số
	"github.com/hyperledger/fabric-contract-api-go/contractapi" // API chaincode
)

type SmartContract struct {
	contractapi.Contract
}

// Main
func main() {
	chaincode, err := contractapi.NewChaincode(&SmartContract{})
	if err != nil {
		fmt.Printf("Lỗi tạo chaincode: %s", err.Error())
		return
	}

	if err := chaincode.Start(); err != nil {
		fmt.Printf("Lỗi khởi động chaincode: %s", err.Error())
	}
}

// Set lưu trữ 5 giá trị gồm asset_mssv, color, number1, hoten, number2
// asset_mssv: string
// color: string
// number1: int
// hoten: string
// number2: int
//set
func (s *SmartContract) Set(ctx contractapi.TransactionContextInterface) error {
	args := ctx.GetStub().GetArgs()
	if len(args) < 6 {
		return fmt.Errorf("Giá trị thiếu")
	}

	key := string(args[1])
	value1 := string(args[2])
	value3 := string(args[4])

	value2, err := strconv.Atoi(string(args[3]))
	if err != nil {
		return fmt.Errorf("ko hop le: %s", err.Error())
	}

	value4, err := strconv.Atoi(string(args[5]))
	if err != nil {
		return fmt.Errorf("ko hop le: %s", err.Error())
	}

	data := map[string]interface{}{
		"asset_mssv": key,
		"color": value1,
		"number1": value2,
		"hoten": value3,
		"number2": value4,
	}

	dataJSON, err := json.Marshal(data)
	if err != nil {
		return fmt.Errorf("Lỗi chuyển đổi dữ liệu sang JSON: %s", err.Error())
	}

	return ctx.GetStub().PutState(key, dataJSON)
}

//get
func (s *SmartContract) Get(ctx contractapi.TransactionContextInterface) (map[string]interface{}, error) {
	args := ctx.GetStub().GetArgs()
	if len(args) < 2 {
		return nil, fmt.Errorf("Key không được trống")
	}
	key := string(args[1])

	dataJSON, err := ctx.GetStub().GetState(key)
	if err != nil {
		return nil, fmt.Errorf("Lỗi: %s", err.Error())
	}
	if dataJSON == nil {
		return nil, fmt.Errorf("Key không tồn tại!")
	}

	var data map[string]interface{}
	err = json.Unmarshal(dataJSON, &data)
	if err != nil {
		return nil, fmt.Errorf("Lỗi chuyển đổi JSON sang map: %s", err.Error())
	}
	return data, nil
}

//update với set nó ko khác gì đâu =)))
func (s *SmartContract) Update(ctx contractapi.TransactionContextInterface) error {
	args := ctx.GetStub().GetArgs()
	if len(args) < 6 {
		return fmt.Errorf("Giá trị thiếu")
	}

	key := string(args[1])
	value1 := string(args[2])
	value3 := string(args[4])

	value2, err := strconv.Atoi(string(args[3]))
	if err != nil {
		return fmt.Errorf("ko hop le: %s", err.Error())
	}

	value4, err := strconv.Atoi(string(args[5]))
	if err != nil {
		return fmt.Errorf("ko hop le: %s", err.Error())
	}

	data := map[string]interface{}{
		"asset_mssv": key,
		"color": value1,
		"number1": value2,
		"hoten": value3,
		"number2": value4,
	}

	dataJSON, err := json.Marshal(data)
	if err != nil {
		return fmt.Errorf("Lỗi chuyển đổi dữ liệu sang JSON: %s", err.Error())
	}

	return ctx.GetStub().PutState(key, dataJSON)
}