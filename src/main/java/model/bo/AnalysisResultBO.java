package model.bo;

import model.bean.AnalysisResult;
import model.dao.AnalysisResultDAO;

public class AnalysisResultBO {
    private final AnalysisResultDAO dao = new AnalysisResultDAO();

    public boolean saveResult(AnalysisResult result) {
        return dao.insert(result);
    }
}
