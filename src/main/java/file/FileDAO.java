package file;

import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;

public class FileDAO {
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
	        System.out.println("데이터베이스 연결 실패-PostDAO");
	    }
	    return conn;
	}
	
	public int upload(String fileName, String fileRealName, int board_id) {
		open();
		String SQL = "INSERT INTO FILE VALUES (?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, fileName);
			pstmt.setString(2, fileRealName);
			pstmt.setInt(3, recent(board_id));
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int recent(int board_id) {
		open();
		String SQL = "SELECT POST_ID FROM POST WHERE BOARD_ID = ? ORDER BY POST_ID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, board_id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				return rs.getInt(1);
			}
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
}
