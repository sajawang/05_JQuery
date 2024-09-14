package kr.or.ddit.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.board.dao.BoardDaoimpl;
import kr.or.ddit.board.dao.IBoardDao;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PageVO;
import kr.or.ddit.board.vo.ReplyVO;

public class BoardServiceimpl implements IBoardService {
	
	//싱글톤
	private static IBoardService service;
	public static IBoardService getService() {
		if(service==null) service = new BoardServiceimpl();
		return service;
	}
	
	//dao객체가필요하다
	private IBoardDao dao;
	private BoardServiceimpl() {
		dao = BoardDaoimpl.getDao();
	}
	
	@Override
	public PageVO pageInfo(int page, String stype, String sword) {

		PageVO pvo = new PageVO();
		
		//전체 글 갯수 가져오기
		//map 설정
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sword", sword); //앞에 있는건mapper 의 $, #붙어있었던 키값들이다.
		map.put("stype", stype); //value는 파라미터인 stype, sword이다.
		
		//전체글갯수 가져오기
		int count = this.countBoard(map);
		//this는 현재 클래스
		System.out.println("count==" + count);
		//전체 페이지수 구하기
		//int totalPage = count / 3; //3개씩 나오기(하드코딩)
		int perList = PageVO.getPerList(); //하드코딩 피하기 위한 VO에서 세팅값 가져오기
		int totalPage = (int) Math.ceil(count / (double)perList);
		//뭐하는 과정????????????????????????????????????????????????????????
		
		
		
		//마지막 페이지(7)에서 마지막 데이터를 지웠을때
		//page변수는 7(마지막페이지) - totalPage = 6으로 바뀜
		if(page > totalPage) page = totalPage;
		
		
		
		//start, end
		int start = (page-1) * perList+1;
		//현재 perList = 3
		//page에 1,2,3 대입하면서 start관찰해보기
		//start가 구해진걸 관찰 할 수 있다.
		
		int end = start + perList-1;
		//start가 1,4,..일때 end가 3,6,....인지 확인
		//perList는 3인 상태
		
		if(count < end) end= count; //end가 21이 나올경우 발생(실제는 20인데) -> end를 count로 방지하는 역할
		
		//startPage endPage -> 1 2 / 3 4 / 5 6 / 7 8
		int perPage = PageVO.getPerPage();
		int startPage = ( (page-1) / perPage * perPage) +1;
		//startPage 관찰 1->1, 1->1, 3->3, 4->3
		
		int endPage = startPage + perPage -1;
		//endPage관찰 : start가 1일때 2가 나와야함
		//					 3    4
		//					 5	  6
		if(endPage > totalPage ) endPage = totalPage;
		
		
		System.out.println("start=" + start);
		System.out.println("end=" + end);
		
		System.out.println("startP=" + startPage);
		System.out.println("endP=" + endPage);
		System.out.println("totalP=" + totalPage);
		
		pvo.setStart(start);
		pvo.setEnd(end);
		pvo.setStartPage(startPage);
		pvo.setEndPage(endPage);
		pvo.setTotalPage(totalPage);
		
		return pvo;
	}

	@Override
	public List<BoardVO> selectBoardList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.selectBoardList(map);
	}

	@Override
	public int countBoard(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.countBoard(map);
	}

	@Override
	public int insertReply(ReplyVO vo) {
		// TODO Auto-generated method stub
		return dao.insertReply(vo);
	}

	@Override
	public List<ReplyVO> selectByReply(int bonum) {
		// TODO Auto-generated method stub
		return dao.selectByReply(bonum);
	}

	@Override
	public int insertBoard(BoardVO vo) {
		// TODO Auto-generated method stub
		return dao.insertBoard(vo);
	}

	@Override
	public int updateHit(int num) {
		// TODO Auto-generated method stub
		return dao.updateHit(num);
	}

	@Override
	public int deleteBoard(int num) {
		// TODO Auto-generated method stub
		return dao.deleteBoard(num);
	}

	@Override
	public int updateBoard(BoardVO vo) {
		// TODO Auto-generated method stub
		return dao.updateBoard(vo);
	}

	@Override
	public int updateReply(ReplyVO vo) {
		// TODO Auto-generated method stub
		return dao.updateReply(vo);
	}

	@Override
	public int deleteReply(int num) {
		// TODO Auto-generated method stub
		return dao.deleteReply(num);
	}

}
