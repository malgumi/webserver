package post;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class PostDAO {
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
	    	System.out.println("데이터베이스 연결 성공!!");
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("데이터베이스 연결 실패");
	    }
	    return conn;
	}


	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return "";
	}

	public int getNext() {
		String SQL = "SELECT post_id FROM POST ORDER BY post_id DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) { 
				return rs.getInt(1)+1;
			}
			return 1;
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return -1;
	}

	public int write(String post_title, String user_id, String post_content, int board_id) {
		String SQL = "INSERT INTO POST VALUES(?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, post_title);
			pstmt.setString(3, post_content);
			pstmt.setString(4, user_id);
			pstmt.setInt(5, board_id);
			pstmt.setString(6, getDate());
			pstmt.setInt(7, 1); //available = 1
			return pstmt.executeUpdate();
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return -1;
	}

	public ArrayList<Post> getList(int pageNumber){
		Connection conn = open();
		String SQL = "SELECT * FROM POST WHERE available = 1 ORDER BY post_id DESC LIMIT ?, 10";
		ArrayList<Post> list = new ArrayList<Post>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 10);
			ResultSet rs = pstmt.executeQuery();
			try(conn; pstmt; rs){
				while (rs.next()) { 
					Post post = new Post();
					post.setPost_id(rs.getInt(1));
					post.setPost_title(rs.getString(2));
					post.setPost_content(rs.getString(3));
					post.setUser_id(rs.getString(4));
					post.setBoard_id(rs.getInt(5));
					post.setDate(rs.getString(6));
					post.setAvailable(rs.getInt(7));
					list.add(post);
				}
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return list;
	}

	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM POST WHERE post_id < ? AND available = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) { 
				return true;
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return false;
	}

	public int Paging() {
	    String SQL = "SELECT COUNT(*) FROM POST WHERE available = 1";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            int result = rs.getInt(1);
	            return result;
	        }
	        return 1;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1; // DB 오류
	}

	public Post getPost(int post_id) {
	    Connection conn = open();
	    String SQL = "SELECT * FROM POST WHERE post_id = ?";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, post_id);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            Post post = new Post();
	            post.setPost_id(rs.getInt(1));
	            post.setPost_title(rs.getString(2));
	            post.setPost_content(rs.getString(3));
	            post.setUser_id(rs.getString(4));
	            post.setBoard_id(rs.getInt(5));
	            post.setDate(rs.getString(6));
	            post.setAvailable(rs.getInt(7));
	            return post;
	        }
	    } catch (Exception e){
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (conn != null) conn.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    return null;
	}


	public int updatePost(int post_id, String post_title, String post_content) {
	    String SQL = "UPDATE POST SET post_title = ?, post_content = ? WHERE post_id =?";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, post_title);
	        pstmt.setString(2, post_content);
	        pstmt.setInt(3, post_id);
	        return pstmt.executeUpdate();
	    } catch (Exception e){
	        e.printStackTrace();
	    }
	    return -1; //데이터베이스 오류
	}

	public int deletePost(int post_id) {
	    String SQL = "UPDATE POST SET available = 0 WHERE post_id = ?";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, post_id);
	        return pstmt.executeUpdate();
	    } catch (Exception e){
	        e.printStackTrace();
	    }
	    return -1; //데이터베이스 오류
	}

}