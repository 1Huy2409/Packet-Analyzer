# 📊 Packet Analyzer - Network Packet Analysis System

Hệ thống phân tích gói tin mạng được xây dựng bằng Java Servlet, JSP và MySQL. Cho phép người dùng upload, lưu trữ và phân tích các file PCAP để hiểu rõ hơn về lưu lượng mạng.

## 🚀 Tính năng

- ✅ **Quản lý người dùng**

  - Đăng ký tài khoản
  - Đăng nhập/Đăng xuất
  - Mã hóa mật khẩu MD5

- ✅ **Upload file**

  - Hỗ trợ nhiều định dạng: `.pcap`, `.pcapng`, `.cap`, `.log`, `.txt`, `.csv`
  - Giới hạn: 500MB/file, 1GB/request
  - Drag & drop interface
  - Progress tracking

- ✅ **Dashboard**
  - Thống kê số file đã upload
  - Giao diện hiện đại, responsive
  - Quản lý file đã upload

## 🛠️ Công nghệ sử dụng

### Backend

- **Java 8**
- **Servlet API 4.0**
- **JSP & JSTL**
- **MySQL 8.0**
- **Maven** - Build tool
- **Tomcat 9** - Application server

### Frontend

- **HTML5 / CSS3**
- **JavaScript (Vanilla)**
- **Responsive Design**

### Libraries

- **MySQL Connector J 8.2.0**
- **Pcap4j 1.8.2** - Packet capture library
- **Gson 2.10.1** - JSON processing
- **JSTL 1.2** - JSP Standard Tag Library

## 📋 Yêu cầu hệ thống

- **JDK**: Java Development Kit 8 trở lên
- **Maven**: Apache Maven 3.6+
- **MySQL**: MySQL 8.0+
- **IDE** (tùy chọn): IntelliJ IDEA, Eclipse, VS Code

## 📦 Cài đặt

### 1. Clone repository

```bash
git clone <repository-url>
cd packet-analyzer-v2
```

### 2. Cấu hình Database

#### Tạo database:

```sql
CREATE DATABASE network_analyzer CHARACTER SET utf8mb4;

USE network_analyzer;
```

#### Tạo bảng users:

```sql
CREATE TABLE users (
    id     INT AUTO_INCREMENT PRIMARY KEY,
    username    VARCHAR(50) UNIQUE NOT NULL,
    password    VARCHAR(255) NOT NULL,
    email       VARCHAR(100)
);
```

#### Tạo bảng file_uploads:

```sql
CREATE TABLE file_uploads (
    id     INT AUTO_INCREMENT PRIMARY KEY,
    user_id     INT NOT NULL,
    file_name   VARCHAR(255) NOT NULL,
    upload_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status      VARCHAR(20) DEFAULT 'PENDING',
    FOREIGN KEY (user_id) REFERENCES users(id)
);
```

### 3. Cấu hình kết nối Database

Mở file `src/main/java/model/dao/DBConnection.java` và cập nhật thông tin:

```java
private static final String URL = "jdbc:mysql://localhost:3306/network_analyzer";
private static final String USER = "root";
private static final String PASSWORD = "your_password_here";
```

### 4. Build và chạy project

#### Sử dụng Maven:

1. Download apache maven, thêm vào Path trong windows

```bash
# Build project
mvn clean package

# Chạy với Cargo plugin (Tomcat 9)
mvn cargo:run
```

#### Hoặc sử dụng IDE:

1. Import project vào IDE
2. Cấu hình Tomcat server
3. Deploy và run

### 5. Truy cập ứng dụng

Mở trình duyệt và truy cập:

```
http://localhost:8080/packet-analyzer
```

## 📁 Cấu trúc thư mục

```
packet-analyzer-v2/
├── src/
│   └── main/
│       ├── java/
│       │   ├── controller/          # Servlet controllers
│       │   │   ├── LoginServlet.java
│       │   │   ├── RegisterServlet.java
│       │   │   ├── LogoutServlet.java
│       │   │   ├── DashboardServlet.java
│       │   │   └── FileUploadServlet.java
│       │   └── model/
│       │       ├── bean/             # Data models
│       │       │   ├── User.java
│       │       │   ├── FileUpload.java
│       │       │   └── AnalystResult.java
│       │       ├── bo/               # Business logic
│       │       │   ├── UserBO.java
│       │       │   └── FileUploadBO.java
│       │       └── dao/              # Database access
│       │           ├── DBConnection.java
│       │           ├── UserDao.java
│       │           └── FileUploadDao.java
│       └── webapp/
│           ├── index.jsp
│           └── WEB-INF/
│               ├── web.xml           # Deployment descriptor
│               └── views/            # JSP views
│                   ├── login.jsp
│                   ├── register.jsp
│                   ├── dashboard.jsp
│                   └── upload.jsp
├── pom.xml                           # Maven configuration
├── .gitignore
└── README.md
```

## 🔐 Bảo mật

- Mật khẩu được mã hóa bằng MD5 (khuyến nghị nâng cấp lên bcrypt cho production)
- Session management để xác thực người dùng
- Validation input trên cả client và server
- CSRF protection (cần implement cho production)

## 📝 API Endpoints

| Endpoint     | Method | Mô tả                       |
| ------------ | ------ | --------------------------- |
| `/login`     | GET    | Hiển thị trang đăng nhập    |
| `/login`     | POST   | Xử lý đăng nhập             |
| `/register`  | GET    | Hiển thị trang đăng ký      |
| `/register`  | POST   | Xử lý đăng ký               |
| `/logout`    | GET    | Đăng xuất                   |
| `/dashboard` | GET    | Trang chủ sau khi đăng nhập |
| `/upload`    | GET    | Trang upload file           |
| `/upload`    | POST   | Xử lý upload file           |

## 🎨 Giao diện

### Trang đăng nhập

- Form đăng nhập với validation
- Link đến trang đăng ký
- Giao diện gradient hiện đại

### Trang đăng ký

- Form đăng ký với validation
- Kiểm tra email hợp lệ
- Kiểm tra độ dài mật khẩu

### Dashboard

- Thống kê số file đã upload
- Cards tính năng chính
- Menu điều hướng

### Trang Upload

- Drag & drop file upload
- Progress bar
- Danh sách file đã upload
- Filter theo định dạng file

## 🐛 Troubleshooting

### Lỗi kết nối database

```
java.sql.SQLException: Access denied for user 'root'@'localhost'
```

**Giải pháp**: Kiểm tra username, password trong `DBConnection.java`

### Lỗi build Maven

```
[ERROR] Failed to execute goal
```

**Giải pháp**:

- Kiểm tra JDK version: `java -version`
- Clean project: `mvn clean`
- Update dependencies: `mvn clean install -U`

### Lỗi Tomcat port đã sử dụng

```
Address already in use: bind
```

**Giải pháp**:

- Đổi port trong `pom.xml` (cargo configuration)
- Hoặc kill process đang dùng port 8080

### Lỗi upload file

```
Cannot delete temporary file
```

**Giải pháp**: Đã được fix trong code bằng try-with-resources và finally block

## 🔄 Các bước tiếp theo

- [ ] Implement chức năng phân tích PCAP file
- [ ] Thêm visualization cho network traffic
- [ ] Export báo cáo PDF/Excel
- [ ] Real-time packet capture
- [ ] RESTful API
- [ ] Frontend framework (React/Vue)
- [ ] Docker containerization
- [ ] Unit testing
- [ ] CI/CD pipeline

## 👥 Đóng góp

1. Fork project
2. Tạo branch mới (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Tạo Pull Request

## 📄 License

Dự án này được phát hành theo giấy phép MIT.

## 📧 Liên hệ

Tên dự án: **Packet Analyzer**  
Version: **1.0-SNAPSHOT**

---

**Made with ❤️ for Network Analysis**
