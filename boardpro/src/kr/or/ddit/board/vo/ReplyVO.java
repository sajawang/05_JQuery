package kr.or.ddit.board.vo;

public class ReplyVO {
	private int renum     ;
	private int bonum     ; //20번글 <- 20번글에 댓글답니다.
	private String name   ; //로그인한 사람 이름
	private String cont   ;
	private String redate ;
	
	public int getRenum() {
		return renum;
	}
	public void setRenum(int renum) {
		this.renum = renum;
	}
	public int getBonum() {
		return bonum;
	}
	public void setBonum(int bonum) {
		this.bonum = bonum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCont() {
		return cont;
	}
	public void setCont(String cont) {
		this.cont = cont;
	}
	public String getRedate() {
		return redate;
	}
	public void setRedate(String redate) {
		this.redate = redate;
	}
	
	
}
