// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract SimpleStorage {
    // Biến trạng thái để lưu trữ một số nguyên
    uint256 public storedData;

    // Hàm nhập dữ liệu (ghi dữ liệu)
    function set(uint256 x) public {
        storedData = x;
    }
    
    // Hàm xuất dữ liệu (đọc dữ liệu)
    function get() public view returns (uint256) {
        return storedData;
    }
}