// Khai báo phiên bản Solidity
    // - Xác định phiên bản solidity để đảm bảo tương thích

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// Định nghĩa contract
contract MyContract {


    // 1. Biến trạng thái (State Variables)
        // - Lưu trữ thông tin trên blockchain (toàn cục cho contract)
        // - Dùng từ khóa như `public`, `private` để xác định phạm vi truy cập
    // Một biến lưu chuỗi, có thể truy cập từ bên ngoài
    string public message;
    // Biến số nguyên không âm
    uint public counter;

    // 2. Hàm khởi tạo (Contructor)
        // - Tự động gọi một lần khi contract được triển khai
        // - Dùng để khởi tạo giá trị ban đầu
    contructer(string memory initiaMessage){
        // Gán giá trị ban đầu cho biến
        message = initiaMessage; 
    }

    // 3. Hàm (Functions)
        // - Có thể là `view` hoặc `pure`: Chỉ đọc dữ liệu, không tốn gas
            // "Không có từ khóa": Thay đổi trạng thái, tốn gas
        // Phạm vi truy cập: `public`, `private`, `internal`, `external`

    // Hàm công khai để lấy thông tin
    function getMessage() public view returns (string memory){
        return message;
    }

    // Hàm công khai để cập nhật dữ liệu
    function setMessage(string memory newMessage) {
        message = newMessage;
    }

    // Hàm thay đổi biến trạng thái
    function incrementCounter()  public {
        counter += 1;
    }

    // hàm nhận Ether
    function deposit(public payable) {}

    // 4, Modifier (Tùy chọn)
        // - Kiểm tra hoặc thêm logic trước khi thực thi hàm.
    modifier onlyOwner(){
        require(msg.sender == owner, "Not authorized");
        _;
    }

    // 5. Sự kiện (Events)
        // Ghi nhận các thay đổi trạng thái hoặc thông tin cần theo dõi
    event MessageUpdated(string oldMessage, string newMessage);

    // 6. Cấu trúc dữ liệu phức tạp (tùy chọn)
        // Dùng `struct` và `mapping` để tổ chức dữ liệu theo ý muốn
    struct User {
        string name;
        uint age;
    }

    mapping(address => User) public users;

    function addUser(string memory name, uint age) public {
        users[msg.sender] = User(name, age);
    }
}