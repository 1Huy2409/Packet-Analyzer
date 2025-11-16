package model.dao;

import model.bean.FileUpload;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FileUploadDao {

    // Lưu thông tin file upload vào database
    public boolean saveFileUpload(FileUpload fileUpload) throws SQLException {
        String sql = "INSERT INTO file_uploads (user_id, file_name, status) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, fileUpload.getUserId());
            stmt.setString(2, fileUpload.getFileName());
            stmt.setString(3, fileUpload.getStatus());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    fileUpload.setId(rs.getInt(1));
                }
                return true;
            }
        }
        return false;
    }

    // Lấy tất cả file uploads của một user
    public List<FileUpload> getFilesByUserId(int userId) throws SQLException {
        List<FileUpload> files = new ArrayList<>();
        String sql = "SELECT * FROM file_uploads WHERE user_id = ? ORDER BY upload_time DESC";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                FileUpload file = new FileUpload();
                file.setId(rs.getInt("id"));
                file.setUserId(rs.getInt("user_id"));
                file.setFileName(rs.getString("file_name"));

                Timestamp timestamp = rs.getTimestamp("upload_time");
                if (timestamp != null) {
                    file.setUploadTime(timestamp.toLocalDateTime());
                }

                file.setStatus(rs.getString("status"));
                files.add(file);
            }
        }
        return files;
    }

    // Lấy file upload theo ID
    public FileUpload getFileById(int id) throws SQLException {
        String sql = "SELECT * FROM file_uploads WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                FileUpload file = new FileUpload();
                file.setId(rs.getInt("id"));
                file.setUserId(rs.getInt("user_id"));
                file.setFileName(rs.getString("file_name"));

                Timestamp timestamp = rs.getTimestamp("upload_time");
                if (timestamp != null) {
                    file.setUploadTime(timestamp.toLocalDateTime());
                }

                file.setStatus(rs.getString("status"));
                return file;
            }
        }
        return null;
    }

    // Cập nhật status của file upload
    public boolean updateFileStatus(int id, String status) throws SQLException {
        String sql = "UPDATE file_uploads SET status = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, id);
            return stmt.executeUpdate() > 0;
        }
    }

    // Xóa file upload
    public boolean deleteFile(int id) throws SQLException {
        String sql = "DELETE FROM file_uploads WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    // Đếm số file uploads của user
    public int countFilesByUserId(int userId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM file_uploads WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
}
