// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract SimpleWallet {
    // Mapping để lưu số dư của từng địa chỉ
    mapping(address => uint256) private balances;

    // Hàm gửi Ether vào hợp đồng và cập nhật số dư
        // Hàm nhận Ether từ người dùng gửi vào hợp đồng // Sử dụng At Address thì mới được
        // Sử dụng khóa `payable` để cho phép gửi Ether
        // Cập nhật số dư của địa chi đang gọi (msg.sender) bằng cách cộng số tiền gửi vào msg.value
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        balances[msg.sender] += msg.value;
    }

    // Hàm lấy số dư của địa chỉ đang gọi
        // Sử dụng khóa `view` để chỉ đọc dữ liệu mà không thay đổi trạng thái
    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    // Hàm lấy số dư của một địa chỉ bất kỳ (chỉ dùng khi kiểm tra)
    function getBalanceOf(address account) public view returns (uint256) {
        return balances[account];
    }
}