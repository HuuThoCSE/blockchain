import "/ontap/test1/1_storage.sol";
import "/ontap/test1/2_owner.sol";

contract Ballot is Storage, Owner {
    function findMax() public view onlyOwner returns (uint) {
        uint max = num1;
        if(num2 > max) {
            max = num2;
        }
        if(num3 > max){
            max = num3;
        }
        return max;
    }
}
