package users;

public class Users {
	private String user_id;
	private String password;
	private String name;
	private int permission;
	private String email;
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String string) {
		this.user_id = string;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPermission() {
		return permission;
	}
	public void setPermission(int permission) {
		this.permission = permission;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
}
