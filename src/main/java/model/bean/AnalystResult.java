package model.bean;

import java.time.LocalDateTime;

public class AnalystResult {
    private int id;
    private int fileId;
    private int tcpCount;
    private int udpCount;
    private double lossRate;
    private double avgRtt;
    private double throughput;
    private LocalDateTime finishTime;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getFileId() {
        return fileId;
    }

    public void setFileId(int fileId) {
        this.fileId = fileId;
    }

    public int getTcpCount() {
        return tcpCount;
    }

    public void setTcpCount(int tcpCount) {
        this.tcpCount = tcpCount;
    }

    public int getUdpCount() {
        return udpCount;
    }

    public void setUdpCount(int udpCount) {
        this.udpCount = udpCount;
    }

    public double getLossRate() {
        return lossRate;
    }

    public void setLossRate(double lossRate) {
        this.lossRate = lossRate;
    }

    public double getAvgRtt() {
        return avgRtt;
    }

    public void setAvgRtt(double avgRtt) {
        this.avgRtt = avgRtt;
    }

    public double getThroughput() {
        return throughput;
    }

    public void setThroughput(double throughput) {
        this.throughput = throughput;
    }

    public LocalDateTime getFinishTime() {
        return finishTime;
    }

    public void setFinishTime(LocalDateTime finishTime) {
        this.finishTime = finishTime;
    }

}
