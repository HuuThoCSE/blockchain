// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// Mã dê, tuổi, cân nặng, giống, và tình trạng sức khỏe.

// Tạo cấu trúc lưu trữ
contract GoatManagement {
    // Cấu trúc lưu trữ thông tin sản phẩm

    struct Goat{
        uint goat_id;
        string goat_code;
        uint goat_age;
        uint goat_breed;
        string healthStatus;
        uint timestamp; // Thời điểm thêm dên
    }

    struct HealthRecord {
        string date;
        string healthStatus;
        string treatment;
    }

    struct Product {
        string productType; // e.g "Milk", "Wool"
        uint quantity; // Amount in liters or kilograms
        string harvestDate; // Ngày thu hoạch
    }

    
}