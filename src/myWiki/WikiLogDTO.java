package myWiki;

import java.sql.Timestamp;

public class WikiLogDTO {
    private int logId;
    private String pageName;
    private String nickname;
    private String logType;
    private Timestamp logTime;
    private int diff;

    public WikiLogDTO(int logId, String pageName, String nickname, String logType, Timestamp logTime, int diff) {
        super();
        this.logId = logId;
        this.pageName = pageName;
        this.nickname = nickname;
        this.logType = logType;
        this.logTime = logTime;
        this.diff = diff;
    }

    public int getLogId() {
        return logId;
    }
    public void setLogId(int logId) {
        this.logId = logId;
    }
    public String getPageName() {
        return pageName;
    }
    public void setPageName(String pageName) {
        this.pageName = pageName;
    }
    public String getNickname() {
        return nickname;
    }
    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
    public String getLogType() {
        return logType;
    }    
    public void setLogType(String logType) {
        this.logType = logType;
    }
    public Timestamp getLogTime() {
        return logTime;
    }
    public void setLogTime(Timestamp logTime) {
        this.logTime = logTime;
    }
    public int getDiff() {
        return diff;
    }
    public void setDiff(int diff) {
        this.diff = diff;
    }
}
