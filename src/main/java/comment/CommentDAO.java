package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

//import COMMENT.Comment;

public class CommentDAO {
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
	        System.out.println("데이터베이스 연결 실패-CommentDAO");
	    }
	    return conn;
	}


	public String comment_getDate() {
		Connection conn = open();
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

	public int comment_getNext() {
		Connection conn = open();
		String SQL = "SELECT comment_id FROM COMMENT ORDER BY comment_id DESC";
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

	public int comment_write(String COMMENT_user_id, int post_id, String Comment_content, int Available) {
		Connection conn = open();
		String SQL = "INSERT INTO COMMENT VALUES(?, ?, ?, ?, ?, ?, ?)"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, comment_getNext()); //위에 ?라고 써뒀던 테이블에 넣을 애들
			pstmt.setString(2, Comment_content); 
			pstmt.setString(3, COMMENT_user_id);
			pstmt.setInt(4, post_id);
			pstmt.setInt(5, 1);//Available
			pstmt.setString(6, comment_getDate()); //available이라 1 넣음..
			return pstmt.executeUpdate(); //성공적일시 상수 반환
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public ArrayList<Comment> comment_getList(int post_id){
		Connection conn = open();
		String SQL = "SELECT * FROM COMMENT WHERE COMMENT_ID = ? AND Available = 1 ORDER BY COMMENT_NUM DESC"; 
		//bbsID가 특정일 때, 그리고 댓글이 삭제가 되지 않았을 때
		ArrayList<Comment> list = new ArrayList<Comment>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, post_id);
			rs = pstmt.executeQuery();
			while (rs.next()) { 
				Comment comment = new Comment();
				comment.setComment_id(rs.getInt(1)); 
				comment.setComment_content(rs.getString(2));
				comment.setUser_id(rs.getString(3));
				comment.setPost_id(rs.getInt(4));
				comment.setAvailable(rs.getInt(5));
				comment.setDate(rs.getString(6));
				list.add(comment); //게시글 목록을 담아서 리스트에 인스턴스 담아서 반환
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return list; //게시글 리스트 반환
	}
	
	public int delete(int comment_id) {
		Connection conn = open();
		String SQL = "UPDATE COMMENT SET Available = 0 WHERE COMMENT_ID = ?"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, comment_id); //ID를 저 물음표에 넣어서 ID값의 글을 삭제
			return pstmt.executeUpdate();
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public Comment getComment(int comment_id) {
		Connection conn = open();
		String SQL = "SELECT * FROM COMMENT WHERE COMMENT_ID = ?"; 
		//bbsID가 특정 숫자일 경우에 실행
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, comment_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {  //결과가 나왔다면
				Comment comment = new Comment();
				comment.setComment_id(rs.getInt(1));
				comment.setComment_content(rs.getString(2));
				comment.setUser_id(rs.getString(3));
				comment.setPost_id(rs.getInt(4));
				comment.setAvailable(rs.getInt(5));
				comment.setDate(rs.getString(6));
				return comment; //bbs에 있는 내용 그대로 반환 및 함수에 전달
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return null; //글이 존재하지 않는 경우
	}

}