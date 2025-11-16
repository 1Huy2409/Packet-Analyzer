package model.bo;

import model.bean.User;
import model.dao.UserDao;
import java.sql.SQLException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

public class UserBO {
    private UserDao userDao;

    public UserBO() {
        this.userDao = new UserDao();
    }

    // Mã hóa password bằng MD5
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : messageDigest) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }

    // Đăng ký user mới
    public String registerUser(String username, String password, String email) {
        try {
            // Validate input
            if (username == null || username.trim().isEmpty()) {
                return "Username không được để trống";
            }
            if (password == null || password.length() < 6) {
                return "Password phải có ít nhất 6 ký tự";
            }
            if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
                return "Email không hợp lệ";
            }

            // Kiểm tra username đã tồn tại
            if (userDao.isUsernameExists(username)) {
                return "Username đã tồn tại";
            }

            // Kiểm tra email đã tồn tại
            if (userDao.isEmailExists(email)) {
                return "Email đã được sử dụng";
            }

            // Tạo user mới
            User user = new User();
            user.setUsername(username);
            user.setPassword(hashPassword(password));
            user.setEmail(email);

            // Lưu vào database
            if (userDao.registerUser(user)) {
                return "SUCCESS";
            } else {
                return "Đăng ký thất bại";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "Lỗi database: " + e.getMessage();
        }
    }

    // Đăng nhập
    public User login(String username, String password) {
        try {
            if (username == null || username.trim().isEmpty() ||
                    password == null || password.trim().isEmpty()) {
                System.out.println("UserBO: Username or password is empty");
                return null;
            }
            String hashedPassword = hashPassword(password);
            System.out.println("UserBO: Hashed password: " + hashedPassword);
            User user = userDao.login(username, hashedPassword);
            System.out.println("UserBO: DAO returned: " + (user != null ? "User found" : "User not found"));
            return user;
        } catch (SQLException e) {
            System.out.println("UserBO: SQL Exception: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    // Lấy user theo ID
    public User getUserById(int id) {
        try {
            return userDao.getUserById(id);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    // Lấy tất cả users
    public List<User> getAllUsers() {
        try {
            return userDao.getAllUsers();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
