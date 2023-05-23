package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BoardDAO {
    private Connection conn;
	private ResultSet rs;
	final String JDBC_DRIVER = "org.h2.Driver";
	final String JDBC_URL = "jdbc:h2:tcp://localhost/~/webserver";
    String dbID = "eagles";
    String dbPassword = "1234";
    
	public Connection open() {
		conn = null;
	    try {
	    	Class.forName(JDBC_DRIVER);
	    	conn = DriverManager.getConnection(JDBC_URL, dbID, dbPassword);
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("데이터베이스 연결 실패-BoardDAO");
	    }
	    return conn;
	}

    public String getBoard_title(int board_id) {
    	Connection conn = open();
        String SQL = "SELECT BOARD_TITLE FROM BOARD WHERE BOARD_ID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, board_id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }
}
