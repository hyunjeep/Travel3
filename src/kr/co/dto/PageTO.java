package kr.co.dto;

import java.util.List;

public class PageTO {
	private int curPage = 1; // 현재 페이지 번호
	private int perPage = 10; // 한 페이지에 표시되는 게시글 수
	private int pageLine = 10; // 페이지를 몇개 보여줄지 정함
	private int amount; // 전체 게시글 수
	private int totalPage; // 총 페이지 갯수
	private int startNum; // 게시글 시작번호 (오라클 rownum 시작 curPage 종속)
	private int endNum; // 게시글 끝번호 (오라클 rownum 끝 curPage 종속)
	private int beginPageNum; // 페이지 시작번호 (오라클 rownum 시작 curPage 종속)
	private int stopPageNum; // 페이지 끝번호 ( (오라클 rownum 시작 curPage 종속)
	private List<BoardDTO> list;

	public PageTO() {
		changeVarVal();
	}

	public PageTO(int curPage) {
		super();
		this.curPage = curPage;
		changeVarVal();
	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
		changeVarVal();
	}

	public int getPerPage() {
		return perPage;
	}

	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}

	public int getPageLine() {
		return pageLine;
	}

	public void setPageLine(int pageLine) {
		this.pageLine = pageLine;
		changeVarVal();
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
		changeVarVal();
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getStartNum() {
		return startNum;
	}

	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}

	public int getEndNum() {
		return endNum;
	}

	public void setEndNum(int endNum) {
		this.endNum = endNum;
	}

	public int getBeginPageNum() {
		return beginPageNum;
	}

	public void setBeginPageNum(int beginPageNum) {
		this.beginPageNum = beginPageNum;
	}

	public int getStopPageNum() {
		return stopPageNum;
	}

	public void setStopPageNum(int stopPageNum) {
		this.stopPageNum = stopPageNum;
	}

	public List<BoardDTO> getList() {
		return list;
	}

	public void setList(List<BoardDTO> list) {
		this.list = list;
	}

	private void changeVarVal() {
		totalPage = amount / perPage;
		if (amount % perPage != 0) {
			totalPage = totalPage + 1;
		}
		startNum = (curPage - 1) * perPage + 1;
		endNum = curPage * perPage;
		if (endNum > amount) {
			endNum = amount;
		}

		beginPageNum = ((curPage - 1) / pageLine) * pageLine + 1;
		stopPageNum = beginPageNum + (pageLine - 1);

		if (stopPageNum > totalPage) {
			stopPageNum = totalPage;
		}
	}

	@Override
	public String toString() {
		return "PageTO [curPage=" + curPage + ", perPage=" + perPage + ", pageLine=" + pageLine + ", amount=" + amount
				+ ", totalPage=" + totalPage + ", startNum=" + startNum + ", endNum=" + endNum + ", beginPageNum="
				+ beginPageNum + ", stopPageNum=" + stopPageNum + ", list=" + list + "]";
	}

}
