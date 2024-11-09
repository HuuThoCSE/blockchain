// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// Mã dê, tuổi, cân nặng, giống, và tình trạng sức khỏe.

// Tạo cấu trúc lưu trữ
contract GoatManagement {
    // Cấu trúc lưu trữ thông tin sản phẩm

    // Định nghĩa các loại giống dê
    enum Breed { Local, BachThao, Boer }

    // Định nghĩa các loại giao phối
    enum MatingType { Internal, External, Artificial }

    struct Goat {
        uint id;
        string code;
        uint age;
        uint weight;
        Breed breed; // Loại giống
        string healthStatus;
        bool isBornInFarm;
        MatingType mattingType; // Loại giao phối
        uint parent1Id; // ID của dê cha (nếu có)
        uint parent2Id; // ID của dê mẹ (nếu có)
        string note; // Ghi chú thêm
        string artificialBreed; // Giống dê trong thụ tinh nhân tạo (nếu có)
    }

    struct HealthRecord {
        string date;
        string healthStatus;
        string treatment;
    }

    struct Product {
        string productType; // e.g "Milk", "Wool"
        uint quantity; // Amount in liters or kilograms
        string harvestDate; // Ngày thu hoạch
    }

    uint public nextGoatId;

    mapping(uint => Goat) public goats;
    mapping(uint => HealthRecord[]) public healthHistory;
    mapping(uint => Product[]) public goatProducts;

    event TransactionDetails(uint gasUsed, bytes32 txHash, uint blockNumber);

    // Hàm chuyển chuỗi thành giá trị enum
    function getEnumValue(string memory _breed) internal pure returns (Breed) {
        if (keccak256(abi.encodePacked(_breed)) == keccak256(abi.encodePacked("Local"))) {
            return Breed.Local;
        } else if (keccak256(abi.encodePacked(_breed)) == keccak256(abi.encodePacked("BachThao"))) {
            return Breed.BachThao;
        } else if (keccak256(abi.encodePacked(_breed)) == keccak256(abi.encodePacked("Boer"))) {
            return Breed.Boer;
        } else {
            revert("Invalid breed type");
        }
    }

    // Ex: "G002", 0, 155, Local

    // Thêm dê mới vào đàn với thời điểm hiện tại
    function addGoat(
        string memory _code, 
        uint _age, 
        uint _weight, 
        string memory _breed, 
        string memory _healthStatus,
        bool isBornInFarm,
        MatingType _matingType,
        uint _parent1Id,
        uint _parent2Id,
        string memory _note,
        string memory _artificialBreed
    ) public {
        Breed breedValue = getEnumValue(_breed); // Chuyển chuỗi thành giá trị enum

        // Kiểm tra giá trị mặc định
        string memory noteValue = bytes(_note).length > 0 ? _note : "No additional notes";
        string memory artificialBreedValue = bytes(_artificialBreed).length > 0 ? _artificialBreed : "N/A";

        goats[nextGoatId] = Goat(
            nextGoatId, 
            _code, 
            _age, 
            _weight, 
            breedValue, 
            _healthStatus,
            isBornInFarm,
            _matingType,
            _parent1Id,
            _parent2Id,
            noteValue,
            artificialBreedValue
        ); // Lưu thời gian hiện tại
        
        nextGoatId++;

        emit TransactionDetails(tx.gasprice, blockhash(block.number - 1), block.number);
    }

    // Cập nhật tình trạng sức khỏe của dê
    // ex: 0, "2024-11-08", "Minor injury", "Applied antiseptic"
    function updateHealth(uint _goatId, string memory _date, string memory _healthStatus, string memory _treatment) public {
        require(goats[_goatId].id == _goatId, "Goat does not exist");
        healthHistory[_goatId].push(HealthRecord(_date, _healthStatus, _treatment));
        goats[_goatId].healthStatus = _healthStatus;

        emit TransactionDetails(tx.gasprice, blockhash(block.number - 1), block.number);
    }

    // Thêm sản phẩm từ dê
    function addProduct(uint _goatId, string memory _productType, uint _quantity, string memory _harvresDate) public {
        require(goats[_goatId].id == _goatId, "Goat does not exist");
        goatProducts[_goatId].push(Product(_productType, _quantity, _harvresDate));

        emit TransactionDetails(tx.gasprice, blockhash(block.number - 1), block.number);
    }

    // Lấy thông tin chi phí thức ăn cho dê dựa trên cân nặng và tuổi
    function calculateFeedCost(uint _goatId) public view returns (uint) {
        Goat memory goat = goats[_goatId];
        uint feedCostPerKg = 5; // Giả định 5 đơn vị tiền cho mọi kg thức ăn
        uint feedCost = goat.weight * feedCostPerKg;
        return feedCost;
    }

    // Tổng chi phí thức ăn cho cả đàn
    function totalMonthlyFeedCost() public view returns(uint) {
        uint totalCost = 0;
        for (uint i = 0; i < nextGoatId; i++){
            totalCost += calculateFeedCost(i);
        }
        return totalCost;
    }

    // Giao phối trong chuồng:
    // addGoat("G127", 0, 10, "Boer", "Healthy", true, MatingType.Internal, 1, 2, "No special note", "");

    // Giao phối với giống ngoài:
    // addGoat("G128", 0, 12, "Native", "Healthy", true, MatingType.External, 0, 0, "Imported from another farm", "");

    // Phối nhân tạo với giống ngoài:
    // addGoat("G129", 0, 11, "BachThao", "Healthy", true, MatingType.Artificial, 0, 0, "Artificial insemination with Boer breed", "Boer");

}
