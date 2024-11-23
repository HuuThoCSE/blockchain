// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Storage {
    uint public num1;
    uint public num2;
    uint public num3;

    function setNumbers(uint _num1, uint _num2, uint _num3) public {
        num1 = _num1;
        num2 = _num2;
        num3 = _num3;
    }

    function getNums() public view returns (uint, uint, uint) {
        return (num1, num2, num3);
    }
}