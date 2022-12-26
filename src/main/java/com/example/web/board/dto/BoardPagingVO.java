package com.example.web.board.dto;

public class BoardPagingVO {
	// 검색
	private String title;
	private int board_type_id;
	private String tags;
	private int likes;
	
	// 페이징 처리
	private int count;			// 총데이터 건수
	private int pageSize;		// 한번에 보여줄 페이지 크기
	private int pageCount;		// 총 페이지 수
	private int curPage;		// 클릭한 현재 페에지 번호
	private int start;			// 시작번호(현재페이지)

	// block
	private int blockSize;		// 한번에 보여줄 block의 크기
	private int startBlock;		// block의 시작번호
	private int endBlock;		// block의 마지막번호
	
	// ~~순
	private String sort;
	
	public BoardPagingVO() {
	}
	
	public BoardPagingVO(int count, int pageSize, int pageCount, int curPage, int start) {
		super();
		this.count = count;
		this.pageSize = pageSize;
		this.pageCount = pageCount;
		this.curPage = curPage;
		this.start = start;
	}

	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}
	public int getBoard_type_id() {
		return board_type_id;
	}
	public void setBoard_type_id(int board_type_id) {
		this.board_type_id = board_type_id;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getBlockSize() {
		return blockSize;
	}
	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}
	public int getStartBlock() {
		return startBlock;
	}
	public void setStartBlock(int startBlock) {
		this.startBlock = startBlock;
	}
	public int getEndBlock() {
		return endBlock;
	}
	public void setEndBlock(int endBlock) {
		this.endBlock = endBlock;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}


	
}
