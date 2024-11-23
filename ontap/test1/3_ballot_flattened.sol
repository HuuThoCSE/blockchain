
// File: ontap/test1/1_storage.sol


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
// File: ontap/test1/2_owner.sol


pragma solidity ^0.8.28;

contract Owner {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }
}
// File: ontap/test1/3_ballot.sol

