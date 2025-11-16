package model.bo;

import model.bean.FileUpload;
import model.dao.FileUploadDao;
import java.sql.SQLException;
import java.util.List;

public class FileUploadBO {
    private FileUploadDao fileUploadDao;

    public FileUploadBO() {
        this.fileUploadDao = new FileUploadDao();
    }

    // Lưu file upload
    public boolean saveFileUpload(FileUpload fileUpload) {
        try {
            return fileUploadDao.saveFileUpload(fileUpload);
        } catch (SQLException e) {
            System.out.println("FileUploadBO: Error saving file upload: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Lấy danh sách file của user
    public List<FileUpload> getFilesByUserId(int userId) {
        try {
            return fileUploadDao.getFilesByUserId(userId);
        } catch (SQLException e) {
            System.out.println("FileUploadBO: Error getting files: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    // Lấy file theo ID
    public FileUpload getFileById(int id) {
        try {
            return fileUploadDao.getFileById(id);
        } catch (SQLException e) {
            System.out.println("FileUploadBO: Error getting file: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    // Cập nhật status
    public boolean updateFileStatus(int id, String status) {
        try {
            return fileUploadDao.updateFileStatus(id, status);
        } catch (SQLException e) {
            System.out.println("FileUploadBO: Error updating status: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Xóa file
    public boolean deleteFile(int id) {
        try {
            return fileUploadDao.deleteFile(id);
        } catch (SQLException e) {
            System.out.println("FileUploadBO: Error deleting file: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Đếm số file
    public int countFilesByUserId(int userId) {
        try {
            return fileUploadDao.countFilesByUserId(userId);
        } catch (SQLException e) {
            System.out.println("FileUploadBO: Error counting files: " + e.getMessage());
            e.printStackTrace();
            return 0;
        }
    }
}
