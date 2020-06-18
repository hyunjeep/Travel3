package kr.co.dto;

import java.io.Serializable;

public class BoardDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private int num;
	private String writer;
	private String title;
	private int locationCode;
	private String locationName;
	private String content;
	private String writeday;
	private int readcnt;
	private int repRoot;
	private int repStep;
	private int repIndent;

	public BoardDTO() {

	}

	public BoardDTO(int num, String writer, String title, int locationCode, String locationName, String content,
			String writeday, int readcnt, int repRoot, int repStep, int repIndent) {
		super();
		this.num = num;
		this.writer = writer;
		this.title = title;
		this.locationCode = locationCode;
		this.locationName = locationName;
		this.content = content;
		this.writeday = writeday;
		this.readcnt = readcnt;
		this.repRoot = repRoot;
		this.repStep = repStep;
		this.repIndent = repIndent;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getLocationCode() {
		return locationCode;
	}

	public void setLocationCode(int locationCode) {
		this.locationCode = locationCode;
	}

	public String getLocationName() {
		return locationName;
	}

	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriteday() {
		return writeday;
	}

	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}

	public int getReadcnt() {
		return readcnt;
	}

	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}

	public int getRepRoot() {
		return repRoot;
	}

	public void setRepRoot(int repRoot) {
		this.repRoot = repRoot;
	}

	public int getRepStep() {
		return repStep;
	}

	public void setRepStep(int repStep) {
		this.repStep = repStep;
	}

	public int getRepIndent() {
		return repIndent;
	}

	public void setRepIndent(int repIndent) {
		this.repIndent = repIndent;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + num;
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
		BoardDTO other = (BoardDTO) obj;
		if (num != other.num)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "BoardDTO [num=" + num + ", writer=" + writer + ", title=" + title + ", locationCode=" + locationCode
				+ ", locationName=" + locationName + ", content=" + content + ", writeday=" + writeday + ", readcnt="
				+ readcnt + ", repRoot=" + repRoot + ", repStep=" + repStep + ", repIndent=" + repIndent + "]";
	}

	
}