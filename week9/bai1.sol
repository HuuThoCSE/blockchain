// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ArrayExample {
    // Tạo mảng động (dynamic array) để lưu trữ các số nguyên
    uint[] public numbers;

    // Hàm thêm phần tử vào mảng
    function addNumber(uint _number) public {
        numbers.push(_number);
    }

    // Hàm lấy phần tử tại một chỉ số cụ thể
    function getNumber(uint _index) public view returns (uint) {
        require(_index < numbers.length, "Index out of bounds");
        return numbers[_index];
    }

    // Hàm xóa phần tử cuối cùng trong mảng
    function removeLastNumber() public {
        require(numbers.length > 0, "Array is empty");
        numbers.pop();
    }

    // Hàm trả về tổng số phần tử trong mảng
    function getLength() public view returns (uint) {
        return numbers.length;
    }

    // Hàm xóa một phần tử tại chỉ số nhất định
    function removeAtIndex(uint _index) public {
        require(_index < numbers.length, "Index out of bounds");
        
        // Di chuyển phần tử cuối cùng vào vị trí cần xóa
        numbers[_index] = numbers[numbers.length - 1];
        
        // Loại bỏ phần tử cuối cùng
        numbers.pop();
    }
}
