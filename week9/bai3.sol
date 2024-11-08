// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ProductManagement {
    // Cấu trúc lưu trữ thông tin sản phẩm
    struct Product {
        uint id;
        string name;
        uint quantity;
        uint price;
    }

    // Mapping để lưu trữ sản phẩm với mã hàng là khóa
    mapping(uint => Product) public products;

    // Biến lưu trữ số lượng sản phẩm
    uint public productCount;

    // Sự kiện cho các giao dịch sản phẩm, bao gồm phí gas, mã hash, và số block
    event TransactionDetails(uint gasUsed, bytes32 txHash, uint blockNumber);

    // Hàm thêm sản phẩm mới. Vd: 1, "MH1", 1, 1000
    function addProduct(uint _id, string memory _name, uint _quantity, uint _price) public {
        require(products[_id].id == 0, "Product ID already exists");
        
        products[_id] = Product(_id, _name, _quantity, _price);
        productCount++;
        
        emit TransactionDetails(tx.gasprice, blockhash(block.number - 1), block.number);
    }

    // Hàm sửa thông tin sản phẩm dựa trên mã hàng
    function updateProduct(uint _id, string memory _name, uint _quantity, uint _price) public {
        require(products[_id].id != 0, "Product ID does not exist");

        products[_id].name = _name;
        products[_id].quantity = _quantity;
        products[_id].price = _price;

        emit TransactionDetails(tx.gasprice, blockhash(block.number - 1), block.number);
    }

    // Hàm xóa sản phẩm dựa trên mã hàng
    function deleteProduct(uint _id) public {
        require(products[_id].id != 0, "Product ID does not exist");

        delete products[_id];
        productCount--;

        emit TransactionDetails(tx.gasprice, blockhash(block.number - 1), block.number);
    }

    // Hàm lấy thông tin sản phẩm dựa trên mã hàng
    function getProduct(uint _id) public view returns (uint, string memory, uint, uint) {
        require(products[_id].id != 0, "Product ID does not exist");
        Product memory product = products[_id];
        return (product.id, product.name, product.quantity, product.price);
    }
}
