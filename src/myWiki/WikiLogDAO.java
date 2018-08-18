package myWiki;

import java.util.ArrayList;

public class WikiLogDAO extends WikiDAO {
    
    public void recordLog(String pageName, String nickname, String logType, int diff) {
        sql = "INSERT INTO log (page_name, nickname, log_type, log_time, log_diff) VALUES(?, ?, ?, now(), ?);";
        try {
            init();
            pstmt.setString(1, pageName);
            pstmt.setString(2, nickname);
            pstmt.setString(3, logType);
            pstmt.setInt(4, diff);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                close();
            } catch (Exception e) {
                e.printStackTrace();
            }            
        }
    }
    
    public ArrayList<WikiLogDTO> readLog() {
        sql = "SELECT * FROM log ORDER BY log_id DESC;";
        try {
            init();
            rs = pstmt.executeQuery();
            ArrayList<WikiLogDTO> logList = new ArrayList<WikiLogDTO>();
            while (rs.next()) {
                logList.add(new WikiLogDTO(rs.getInt(1), rs.getString(2), rs.getString(3),
                                           rs.getString(4), rs.getTimestamp(5), rs.getInt(6)));
            }
            return logList;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }
    
    public ArrayList<WikiLogDTO> readLog(String pageName) {
        sql = "SELECT * FROM log WHERE page_name = ? ORDER BY log_id DESC;";
        try {
            init();
            pstmt.setString(1, pageName);
            rs = pstmt.executeQuery();
            ArrayList<WikiLogDTO> logList = new ArrayList<WikiLogDTO>();
            while (rs.next()) {
                logList.add(new WikiLogDTO(rs.getInt(1), rs.getString(2), rs.getString(3),
                                           rs.getString(4), rs.getTimestamp(5), rs.getInt(6)));
            }
            return logList;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }
    
}
