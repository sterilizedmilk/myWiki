package myWiki;

import java.sql.SQLException;
import java.util.ArrayList;

public class WikiPageDAO extends WikiDAO {

    public boolean isPageExist(String name) {
        sql = "SELECT COUNT(*) FROM page WHERE page_name = ?;";
        try {
            init();
            pstmt.setString(1, name);
            rs = pstmt.executeQuery();
            if (rs.next() && rs.getInt(1) != 0)
                return true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public boolean createPage(WikiPageDTO dto) {
        sql = "INSERT INTO page (page_name, page_content) VALUES(?, ?);";
        try {
            init();
            pstmt.setString(1, dto.getName());
            pstmt.setString(2, dto.getContent());
            return pstmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public int updatePage(String name, String content) {
        sql = "UPDATE page SET page_content = ? WHERE page_name = ?;";
        try {
            init();
            pstmt.setString(1, content);
            pstmt.setString(2, name);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return -1;
    }

    public String readPage(String name) {
        sql = "SELECT page_content FROM page WHERE page_name = ?;";
        try {
            init();
            pstmt.setString(1, name);
            rs = pstmt.executeQuery();
            if (rs.next())
                return rs.getString(1);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public ArrayList<WikiPageDTO> search(String keyword) {
        sql = "SELECT page_name, page_content FROM page WHERE page_name LIKE ? OR page_content LIKE ?;";
        ArrayList<WikiPageDTO> pages = null;
        try {
            init();
            pstmt.setString(1, '%' + keyword + '%');
            pstmt.setString(2, '%' + keyword + '%');
            rs = pstmt.executeQuery();
            pages = new ArrayList<WikiPageDTO>();
            while (rs.next()) {
                String content = rs.getString(2);
                pages.add(new WikiPageDTO(rs.getString(1),
                        content.length() <= 200 ? content : content.substring(0, 200) + "..."));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return pages;
    }

    public String randomPage() {
        sql = "SELECT page_name FROM page ORDER BY RAND() LIMIT 1;";
        try {
            init();
            rs = pstmt.executeQuery();
            if (rs.next())
                return rs.getString(1);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return "";
    }

    public int deletePage(String name) {
        int deleteNum = 0;
        sql = "DELETE FROM page WHERE page_name = ?;";
        try {
            init();
            pstmt.setString(1, name);
            deleteNum = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return deleteNum;
    }
}
