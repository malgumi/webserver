package users;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import post.Post;

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
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("데이터베이스 연결 실패-userDAO");
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
			Connection conn = open();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, users.getUser_id());
			pstmt.setString(2, users.getPassword());
			pstmt.setString(3, users.getName());
			//pstmt.setInt(4, users.getPermission());
			pstmt.setString(4, users.getEmail());

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
		Connection conn = open();
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
		Connection conn = open();
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
		Connection conn = open();
		String SQL = "UPDATE USERS SET Password = ?, Name = ?, Email = ? WHERE user_id =?"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, Password);
			pstmt.setString(2, Name);
			pstmt.setString(3, Email);
			pstmt.setString(4, User_id); // user_id를 WHERE 절에 추가
			return pstmt.executeUpdate();
			
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
	
	public int AdminUpdateUserdata(String User_id, String Password, String Name, int Permission, String Email) {
		Connection conn = open();
		String SQL = "UPDATE USERS SET Password = ?, Name = ?, Email = ?, Permission = ? WHERE user_id =?"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, Password);
			pstmt.setString(2, Name);
			pstmt.setString(3, Email);
			pstmt.setInt(4, Permission);
			pstmt.setString(5, User_id); // user_id를 WHERE 절에 추가
			return pstmt.executeUpdate();
			
		}
		catch (Exception e){
			e.printStackTrace();
		}
		
		return -1; //데이터베이스 오류
	}
	
	public Users findUserByEmail(String Email) {
	    Connection conn = open();
	    String SQL = "SELECT * FROM USERS WHERE email = ?";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, Email);
	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) {
	            Users user = new Users();
	            user.setUser_id(rs.getString("user_id"));
	            user.setPassword(rs.getString("password"));
	            user.setName(rs.getString("name"));
	            user.setPermission(rs.getInt("permission"));
	            user.setEmail(rs.getString("email"));
	            return user;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null;
	}
	
	public ArrayList<Users> getList() { //main용 최신글 출력
	    Connection conn = open();
	    String SQL = "SELECT * FROM USERS WHERE permission = 1";
	    ArrayList<Users> list = new ArrayList<Users>();
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        ResultSet rs = pstmt.executeQuery();
	        try(conn; pstmt; rs) {
	            while (rs.next()) {
	                Users user = new Users();
	                user.setUser_id(rs.getString(1));
	                user.setPassword(rs.getString(2));
	                user.setName(rs.getString(3));
	                user.setEmail(rs.getString(5));
	                //user.setPermission(rs.getInt(5));
	                list.add(user);
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
	
}