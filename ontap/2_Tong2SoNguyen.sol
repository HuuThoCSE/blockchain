// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Sum {
    uint sum1;

    function addNum(uint x, uint y) public  {
        sum1 = x + y;
    }

    function getSum() public view returns (uint) {
        return sum1;
    }
}