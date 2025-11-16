package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/network_analyzer";
    private static final String USER = "root";
    private static final String PASSWORD = "nhathuy2409";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Cannot load JDBC driver", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}