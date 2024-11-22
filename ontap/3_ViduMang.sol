// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ArrayExample {
    // Tạo mãng động (dynamic array) để lưu trữ các số nguyên

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
    function removeLastNum() public  {
        require(numbers.length > 0, "Array is empty");
        numbers.pop();
    }

    // Hàm trả về tổng phần tử trong mãng
    function getLength() public view returns (uint) {
        return numbers.length;
    }

    // Hàm xóa một phần tử từ tại chỉ số nhất định
    function removeAtIndex(uint _index) public  {
        require(_index < numbers.length, "Index out of bounds");
        
        // Di chuyển phần từ cuối cùng vào trí ví cần xóa 
        numbers[_index] = numbers[numbers.length - 1];

        // Loại bỏ phần tử cuối cùng
        numbers.pop();

    }
}