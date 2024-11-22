// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract HelloWorld {
    // Hàm public trả về thông điệp "Hello World"
    function getMessage() public pure returns (string memory) {
        return "Hello World"; // Trả về chuỗi "Hello World"
    }
}