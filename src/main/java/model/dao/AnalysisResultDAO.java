package model.dao;

import model.bean.AnalysisResult;
import java.sql.*;

public class AnalysisResultDAO {

    // Lưu kết quả phân tích vào database
    public boolean insert(AnalysisResult result) {
        String sql = "INSERT INTO analysis_results " +
                "(file_id, total_flows, total_bytes_sent, total_bytes_received, " +
                "avg_throughput_sent, avg_throughput_receive, avg_rtt, avg_flow_duration, " +
                "avg_packet_size_mean, tcp_flows, udp_flows, other_flows, processing_time_ms) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, result.getFileId());
            stmt.setInt(2, result.getTotalFlows());
            stmt.setLong(3, result.getTotalBytesSent());
            stmt.setLong(4, result.getTotalBytesReceived());
            stmt.setDouble(5, result.getAvgThroughputSent());
            stmt.setDouble(6, result.getAvgThroughputReceive());
            stmt.setDouble(7, result.getAvgRtt());
            stmt.setDouble(8, result.getAvgFlowDuration());
            stmt.setDouble(9, result.getAvgPacketSizeMean());
            stmt.setInt(10, result.getTcpFlows());
            stmt.setInt(11, result.getUdpFlows());
            stmt.setInt(12, result.getOtherFlows());
            stmt.setLong(13, result.getProcessingTimeMs());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    result.setResultId(rs.getInt(1));
                }
                System.out.println("Analysis result saved successfully. Result ID: " + result.getResultId());
                return true;
            }
        } catch (SQLException e) {
            System.out.println("Error saving analysis result: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Lấy kết quả phân tích theo file_id
    public AnalysisResult getByFileId(int fileId) {
        String sql = "SELECT * FROM analysis_results WHERE file_id = ? ORDER BY created_at DESC LIMIT 1";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, fileId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                AnalysisResult result = new AnalysisResult();
                result.setResultId(rs.getInt("result_id"));
                result.setFileId(rs.getInt("file_id"));
                result.setTotalFlows(rs.getInt("total_flows"));
                result.setTotalBytesSent(rs.getLong("total_bytes_sent"));
                result.setTotalBytesReceived(rs.getLong("total_bytes_received"));
                result.setAvgThroughputSent(rs.getDouble("avg_throughput_sent"));
                result.setAvgThroughputReceive(rs.getDouble("avg_throughput_receive"));
                result.setAvgRtt(rs.getDouble("avg_rtt"));
                result.setAvgFlowDuration(rs.getDouble("avg_flow_duration"));
                result.setAvgPacketSizeMean(rs.getDouble("avg_packet_size_mean"));
                result.setTcpFlows(rs.getInt("tcp_flows"));
                result.setUdpFlows(rs.getInt("udp_flows"));
                result.setOtherFlows(rs.getInt("other_flows"));
                result.setProcessingTimeMs(rs.getLong("processing_time_ms"));
                result.setCreatedAt(rs.getTimestamp("created_at"));
                return result;
            }
        } catch (SQLException e) {
            System.out.println("Error getting analysis result: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // Lấy kết quả theo result_id
    public AnalysisResult getById(int resultId) {
        String sql = "SELECT * FROM analysis_results WHERE result_id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, resultId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                AnalysisResult result = new AnalysisResult();
                result.setResultId(rs.getInt("result_id"));
                result.setFileId(rs.getInt("file_id"));
                result.setTotalFlows(rs.getInt("total_flows"));
                result.setTotalBytesSent(rs.getLong("total_bytes_sent"));
                result.setTotalBytesReceived(rs.getLong("total_bytes_received"));
                result.setAvgThroughputSent(rs.getDouble("avg_throughput_sent"));
                result.setAvgThroughputReceive(rs.getDouble("avg_throughput_receive"));
                result.setAvgRtt(rs.getDouble("avg_rtt"));
                result.setAvgFlowDuration(rs.getDouble("avg_flow_duration"));
                result.setAvgPacketSizeMean(rs.getDouble("avg_packet_size_mean"));
                result.setTcpFlows(rs.getInt("tcp_flows"));
                result.setUdpFlows(rs.getInt("udp_flows"));
                result.setOtherFlows(rs.getInt("other_flows"));
                result.setProcessingTimeMs(rs.getLong("processing_time_ms"));
                result.setCreatedAt(rs.getTimestamp("created_at"));
                return result;
            }
        } catch (SQLException e) {
            System.out.println("Error getting analysis result: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
