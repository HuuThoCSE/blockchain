// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract SimpleStorage {
    // Biến trạng thái để lưu giá trị số nguyên
    uint256 private storedValue; // Lưu giá trị số nguyên, private chỉ được truy cập thông qua các hàm trong hợp đồng

    // Hàm lưu giá trị vào biến trạng thái
    function store(uint256 value) public {
        storedValue = value;
    }

    // Hàm lấy giá trị đã lưu
    // `view` chỉ đọc dữ liệu mà không thay đổi trạng thái hợp đồng.
    function retrieve() public view returns (uint256) {
        return storedValue;
    }
}