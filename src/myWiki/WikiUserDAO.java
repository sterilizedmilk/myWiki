package myWiki;

public class WikiUserDAO extends WikiDAO{
    
    public boolean passwordCheck(String nickname, String password) {
        sql = "SELECT COUNT(*) FROM user WHERE nickname = ? AND password = ?;";
        try {
            init();
            pstmt.setString(1, nickname);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            if (rs.next() && rs.getInt(1) != 0)
                return true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }
    
    public boolean nicknameDuplicateCheck(String nickname) {
        sql = "SELECT COUNT(*) FROM user WHERE nickname = ?;";
        try {
            init();
            pstmt.setString(1, nickname);
            rs = pstmt.executeQuery();
            if (rs.next() && rs.getInt(1) == 0)
                return true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }
    
    public void register(String nickname, String password) {
        sql = "INSERT INTO user SET nickname = ?, password = ?;";
        try {
            init();
            pstmt.setString(1, nickname);
            pstmt.setString(2, password);            
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
        return;
    }
    
    
}
