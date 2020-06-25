package kr.co.dto;

import java.io.Serializable;

public class FileDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private int fileNum;
	private String fileName;
	private String orgFileName;
	private String fileUrl;

	public FileDTO() {

	}

	public FileDTO(int fileNum) {
		super();
		this.fileNum = fileNum;
	}

	public FileDTO(int fileNum, String fileName, String orgFileName, String fileUrl) {
		super();
		this.fileNum = fileNum;
		this.fileName = fileName;
		this.orgFileName = orgFileName;
		this.fileUrl = fileUrl;
	}

	public int getFileNum() {
		return fileNum;
	}

	public void setFileNum(int fileNum) {
		this.fileNum = fileNum;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getOrgFileName() {
		return orgFileName;
	}

	public void setOrgFileName(String orgFileName) {
		this.orgFileName = orgFileName;
	}

	public String getFileUrl() {
		return fileUrl;
	}

	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + fileNum;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		FileDTO other = (FileDTO) obj;
		if (fileNum != other.fileNum)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "FileDTO [fileNum=" + fileNum + ", fileName=" + fileName + "]";
	}
	
}