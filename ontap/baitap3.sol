// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract SaveInterger {
    // Biến trạng thái lưu thông điệp
    int256 public num;

    function saveNum(string memory newNum) public  {
        num = storage(newNum);
    }

    function takeNum() public view returns (string num) {
        return num;
    }
}