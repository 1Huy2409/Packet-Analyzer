package model.bean;

import java.sql.Timestamp;

public class AnalysisResult {
    private int resultId;
    private int fileId;

    private int totalFlows;
    private long totalBytesSent;
    private long totalBytesReceived;

    private double avgThroughputSent;
    private double avgThroughputReceive;

    private double avgRtt;
    private double avgFlowDuration;
    private double avgPacketSizeMean;

    private int tcpFlows;
    private int udpFlows;
    private int otherFlows;

    private long processingTimeMs;
    private Timestamp createdAt;

    // Getters and Setters
    public int getResultId() {
        return resultId;
    }

    public void setResultId(int resultId) {
        this.resultId = resultId;
    }

    public int getFileId() {
        return fileId;
    }

    public void setFileId(int fileId) {
        this.fileId = fileId;
    }

    public int getTotalFlows() {
        return totalFlows;
    }

    public void setTotalFlows(int totalFlows) {
        this.totalFlows = totalFlows;
    }

    public long getTotalBytesSent() {
        return totalBytesSent;
    }

    public void setTotalBytesSent(long totalBytesSent) {
        this.totalBytesSent = totalBytesSent;
    }

    public long getTotalBytesReceived() {
        return totalBytesReceived;
    }

    public void setTotalBytesReceived(long totalBytesReceived) {
        this.totalBytesReceived = totalBytesReceived;
    }

    public double getAvgThroughputSent() {
        return avgThroughputSent;
    }

    public void setAvgThroughputSent(double avgThroughputSent) {
        this.avgThroughputSent = avgThroughputSent;
    }

    public double getAvgThroughputReceive() {
        return avgThroughputReceive;
    }

    public void setAvgThroughputReceive(double avgThroughputReceive) {
        this.avgThroughputReceive = avgThroughputReceive;
    }

    public double getAvgRtt() {
        return avgRtt;
    }

    public void setAvgRtt(double avgRtt) {
        this.avgRtt = avgRtt;
    }

    public double getAvgFlowDuration() {
        return avgFlowDuration;
    }

    public void setAvgFlowDuration(double avgFlowDuration) {
        this.avgFlowDuration = avgFlowDuration;
    }

    public double getAvgPacketSizeMean() {
        return avgPacketSizeMean;
    }

    public void setAvgPacketSizeMean(double avgPacketSizeMean) {
        this.avgPacketSizeMean = avgPacketSizeMean;
    }

    public int getTcpFlows() {
        return tcpFlows;
    }

    public void setTcpFlows(int tcpFlows) {
        this.tcpFlows = tcpFlows;
    }

    public int getUdpFlows() {
        return udpFlows;
    }

    public void setUdpFlows(int udpFlows) {
        this.udpFlows = udpFlows;
    }

    public int getOtherFlows() {
        return otherFlows;
    }

    public void setOtherFlows(int otherFlows) {
        this.otherFlows = otherFlows;
    }

    public long getProcessingTimeMs() {
        return processingTimeMs;
    }

    public void setProcessingTimeMs(long processingTimeMs) {
        this.processingTimeMs = processingTimeMs;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
