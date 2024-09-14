package kr.or.ddit.board.vo;

public class PageVO {
	private int start;
	private int end;
	
	private int startPage;
	//이거 다 페이지 계산하는거에여
	private int endPage;
	private int totalPage;
	private static int perList = 3; //한페이지에 3개씩 찍어라.//한페이지당 출력하는 글 갯수
	//글쓰기하면 계속 데이터가 늘어나잖아.
	//데이터가 많으면 한페이지에 3개씩 찍으면 안되겠지
	//나중엔 고칠거에여.
	private static int perPage = 2; //페이지 블럭 12 34 56 한번에 두개씩 //글개수가 많아지면 고칠거에여
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public static int getPerList() {
		return perList;
	}
	public static void setPerList(int perList) {
		PageVO.perList = perList;
	}
	public static int getPerPage() {
		return perPage;
	}
	public static void setPerPage(int perPage) {
		PageVO.perPage = perPage;
	}
	
	
}
