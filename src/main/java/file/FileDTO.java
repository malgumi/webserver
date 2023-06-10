package file;

public class FileDTO {
	String fileName;
	String fileRealName;
	int post_id;
	public int getPost_id() {
		return post_id;
	}
	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileRealName() {
		return fileRealName;
	}
	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}
	public FileDTO(String fileName, String fileRealName, int post_id) {
		super();
		this.fileName = fileName;
		this.fileRealName = fileRealName;
		this.post_id = post_id;
	}
	
}
