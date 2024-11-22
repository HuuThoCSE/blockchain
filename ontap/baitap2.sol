// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract MessageContract {
    // Biến trạng thái để lưu thông điệp
    string public message;

    // Hàm khởi tạo (contructor) để gán giá trị ban đầu
        // Là phải tạo giá trị từ lúc đầu
    constructor(string memory initiaMessage) {
        message = initiaMessage;
    }

    // Hàm public để lấy thông điệp hiện tại
    function getMessage() public view returns (string memory) {
        return message;
    }

    // Hàm public để cập nhật thông điệp mới
    function setMessage(string memory newMessage) public {
        message = newMessage;
    }
}
