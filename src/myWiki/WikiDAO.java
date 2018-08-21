package myWiki;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public abstract class WikiDAO {
    protected Connection conn = null;
    protected PreparedStatement pstmt = null;
    protected ResultSet rs = null;
    protected String sql = null;

    protected static String url = "jdbc:mysql://localhost:3306/wiki?useSSL=false&characterEncoding=utf8";
    protected static String id = "root"; // your id
    protected static String password = "password"; // your password

    protected void init() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, id, password);
        pstmt = conn.prepareStatement(sql);
    }

    protected void close() throws SQLException {
        pstmt.close();
        conn.close();
        rs = null;
        sql = null;
    }
}
