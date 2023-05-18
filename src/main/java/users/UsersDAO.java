package users;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsersDAO {
	private Connection conn;
	private ResultSet rs;
	private PreparedStatement pstmt;
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
	
	public int login(String user_id, String password) {
		String SQL = "SELECT password FROM USERS WHERE user_id = ?";
		
		try {
			Connection conn = open();
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(password)) {
					return 1;//success login
				}
				else {
					return 0;//failed login
				}
			}
			return -1;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	public int join(Users users) {
		String SQL = "INSERT INTO USERS VALUES (?, ?, ?, 1, ?)";
		try {
			conn = open();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, users.getUser_id());
			pstmt.setString(2, users.getPassword());
			pstmt.setString(3, users.getName());
			//pstmt.setInt(4, users.getPermission());
			pstmt.setString(4, users.getEmail());
			//pstmt.setString(6, users.getUserNickname());

			return pstmt.executeUpdate(); //결과를 집어넣는거??
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {if(conn != null) {conn.close();}} catch (Exception ex) {ex.printStackTrace();}
			try {if(rs != null)   {rs.close();}}   catch (Exception ex) {ex.printStackTrace();}
			try {if(pstmt != null){pstmt.close();}}catch (Exception ex) {ex.printStackTrace();}
		}
		
		return -1; //DB오류. INSERT문이 실행되면 반드시 0 넘는 숫자가 반환됨
	}
	
	public Users getUserdata(String user_id) {
		String SQL = "SELECT * FROM USERS where user_id = ?";
		try {
			pstmt = conn.prepareStatement(SQL); 
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Users user = new Users();
				user.setUser_id(rs.getString(1));
				user.setPassword(rs.getString(2));
				user.setName(rs.getString(3));
				user.setPermission(rs.getInt(4));
				user.setEmail(rs.getString(5));
				return user;
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	public int name(String name) {//닉네임 중복 체크 
		String SQL = "SELECT Name from USERS where Name = ?";
		try {
			pstmt = conn.prepareStatement(SQL); 
			pstmt.setString(1, name);//SQL 인젝션같은 해킹기법 방어
			rs = pstmt.executeQuery();

			if(rs.next()) { //결과가 존재 한다면 실행
				if(rs.getString(1).equals(name)) {
					return -1;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}	
		
		return 1;
	}
	
	public int updateUserdata(String User_id, String Password, String Name, int Permission, String Email) {
		String SQL = "UPDATE USERS SET Password = ?, Name = ?, Email = ? WHERE user_id =?"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, Password);
			pstmt.setString(2, Name);
			pstmt.setString(3, Email);
			
			//2.3배정훈 추가 닉네임 수정 사항 없으면 그냥 넘어가고 있으면 닉네임 중복되는지 확인 후 수정 
//			String pname = nameserach(User_id);
//			int name = name(userNickname);
//			if(pname.equals(userNickname)) {
//				return pstmt.executeUpdate();
//			}
//			else {
//				if(name != -1) {
//					return pstmt.executeUpdate();
//				}
//				else {
//					return -2; //닉네임이 중복되는 경우
//				}
//			}			
			
		}
		catch (Exception e){
			e.printStackTrace();
		}
		
		return -1; //데이터베이스 오류
	}
	
}