package model.worker;

import model.bean.AnalysisResult;
import model.dao.AnalysisResultDAO;
import model.bo.FileUploadBO;

import java.io.BufferedReader;
import java.io.FileReader;

public class AnalyzerWorker implements Runnable {

    private final int fileId;
    private final String filePath;

    private final FileUploadBO fileUploadBO = new FileUploadBO();
    private final AnalysisResultDAO resultDAO = new AnalysisResultDAO();

    public AnalyzerWorker(int fileId, String filePath) {
        this.fileId = fileId;
        this.filePath = filePath;
    }

    @Override
    public void run() {

        long start = System.currentTimeMillis();

        fileUploadBO.updateStatus(fileId, "PROCESSING");
        System.out.println("[AnalyzerWorker] Starting analysis for file ID: " + fileId);
        System.out.println("[AnalyzerWorker] File path: " + filePath);

        int totalFlows = 0;
        long totalBytesSent = 0;
        long totalBytesReceived = 0;

        double sumThroughputSent = 0;
        double sumThroughputReceive = 0;

        double sumRTT = 0;
        double sumFlowDuration = 0;
        double sumPacketSizeMean = 0;

        int tcpFlows = 0;
        int udpFlows = 0;
        int otherFlows = 0;

        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;

            // Bỏ header
            String header = br.readLine();
            System.out.println("[AnalyzerWorker] Header: " + header);

            while ((line = br.readLine()) != null) {
                if (line.trim().isEmpty())
                    continue;

                String[] c = line.split(",");

                // Map cột theo file CSV:
                // 0 - SourceIP
                // 1 - DestinationIP
                // 2 - TimeStamp
                // 3 - Total bytes sent
                // 4 - Total bytes received
                // 5 - Throughput sent
                // 6 - Throughput received
                // 7 - Average RTT
                // 8 - Average flow duration
                // 9 - Average packet size mean
                // 10 - Protocol

                long bytesSent = parseLong(c[3]);
                long bytesReceived = parseLong(c[4]);

                double thrSent = parseDouble(c[5]);
                double thrReceive = parseDouble(c[6]);

                double avgRTT = parseDouble(c[7]);
                double flowDuration = parseDouble(c[8]);
                double packetSizeMean = parseDouble(c[9]);

                String protocol = c[10].trim().toUpperCase();

                // Tính toán
                totalFlows++;

                totalBytesSent += bytesSent;
                totalBytesReceived += bytesReceived;

                sumThroughputSent += thrSent;
                sumThroughputReceive += thrReceive;
                sumRTT += avgRTT;
                sumFlowDuration += flowDuration;
                sumPacketSizeMean += packetSizeMean;

                switch (protocol) {
                    case "TCP":
                        tcpFlows++;
                        break;
                    case "UDP":
                        udpFlows++;
                        break;
                    default:
                        otherFlows++;
                }
            }

            System.out.println("[AnalyzerWorker] Total flows processed: " + totalFlows);

            // Tính trung bình
            AnalysisResult result = new AnalysisResult();
            result.setFileId(fileId);
            result.setTotalFlows(totalFlows);
            result.setTotalBytesSent(totalBytesSent);
            result.setTotalBytesReceived(totalBytesReceived);

            if (totalFlows > 0) {
                result.setAvgThroughputSent(sumThroughputSent / totalFlows);
                result.setAvgThroughputReceive(sumThroughputReceive / totalFlows);
                result.setAvgRtt(sumRTT / totalFlows);
                result.setAvgFlowDuration(sumFlowDuration / totalFlows);
                result.setAvgPacketSizeMean(sumPacketSizeMean / totalFlows);
            }

            result.setTcpFlows(tcpFlows);
            result.setUdpFlows(udpFlows);
            result.setOtherFlows(otherFlows);

            long end = System.currentTimeMillis();
            result.setProcessingTimeMs(end - start);

            System.out.println("[AnalyzerWorker] Processing time: " + result.getProcessingTimeMs() + "ms");
            System.out.println(
                    "[AnalyzerWorker] TCP flows: " + tcpFlows + ", UDP flows: " + udpFlows + ", Other: " + otherFlows);

            // Lưu vào DB
            boolean saved = resultDAO.insert(result);

            if (saved) {
                fileUploadBO.updateStatus(fileId, "COMPLETED");
                System.out.println("[AnalyzerWorker] File analyzed successfully: COMPLETED");
            } else {
                fileUploadBO.updateStatus(fileId, "FAILED");
                System.out.println("[AnalyzerWorker] Failed to save analysis result");
            }

        } catch (Exception e) {
            System.out.println("[AnalyzerWorker] Error analyzing file: " + e.getMessage());
            e.printStackTrace();
            fileUploadBO.updateStatus(fileId, "FAILED");
        }
    }

    private long parseLong(String s) {
        try {
            return Long.parseLong(s.trim());
        } catch (Exception e) {
            return 0;
        }
    }

    private double parseDouble(String s) {
        try {
            return Double.parseDouble(s.trim());
        } catch (Exception e) {
            return 0.0;
        }
    }
}
