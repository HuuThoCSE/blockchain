// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract QLSanpham {
    struct Sanpham {
        string MaSP;
        string TenSP;
        uint SLSP;
        uint DGSP;
    }

    Sanpham[] public DSSanpham;

    // Sự kiện khi thêm sản phẩm
    event SPThem(string maSP, string tenSP, uint SLSP, uint DGSP);

    // Hàm thêm sản phẩm vào danh sách
    function ThemSP(string memory _maSP, string memory _tenSP, uint _SLSP, uint _DGSP) public {
        DSSanpham.push(Sanpham(_maSP, _tenSP, _SLSP, _DGSP));
        emit SPThem(_maSP, _tenSP, _SLSP, _DGSP);
    }

    function InDSSanpham() public view returns (Sanpham[] memory) {
        return DSSanpham;
    }
}
