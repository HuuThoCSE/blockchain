// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract StringArrayExample {
    // Mảng động chứa các chuỗi ký tự
    string[] public strings;

    // Hàm thêm chuỗi vào mảng
    function addString(string memory _string) public {
        strings.push(_string);
    }

    // Hàm lấy chuỗi tại một chỉ số nhất định
    function getString(uint _index) public view returns (string memory) {
        require(_index < strings.length, "Index out of bounds");
        return strings[_index];
    }

    // Hàm xóa chuỗi cuối cùng trong mảng
    function removeLastString() public {
        require(strings.length > 0, "Array is empty");
        strings.pop();
    }

    // Hàm trả về số lượng chuỗi trong mảng
    function getLength() public view returns (uint) {
        return strings.length;
    }

    // Hàm xóa chuỗi tại một chỉ số nhất định
    function removeAtIndex(uint _index) public {
        require(_index < strings.length, "Index out of bounds");
        
        // Di chuyển chuỗi cuối cùng vào vị trí cần xóa
        strings[_index] = strings[strings.length - 1];
        
        // Loại bỏ chuỗi cuối cùng
        strings.pop();
    }

    // Hàm trả về toàn bộ chuỗi trong mảng dưới dạng một chuỗi gộp
    function getAllStrings() public view returns (string memory) {
        string memory allStrings = "";
        
        for (uint i = 0; i < strings.length; i++) {
            allStrings = string(abi.encodePacked(allStrings, strings[i], " "));
        }
        
        return allStrings;
    }
}
