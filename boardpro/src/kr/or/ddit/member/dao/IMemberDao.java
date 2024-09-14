package kr.or.ddit.member.dao;

import java.util.List;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.ZipVO;

public interface IMemberDao {
	
	
	//service-dao-mapper의 메소드 이름이 모두 같으면 편하다
	public List<MemberVO> selectAllMember();
	
	//멤버 리스트 가져오기
		//이름을 아무거나 써도 되지만, mapper쓸때 id찾기 힘듦.
		//mapper의 id값 그대로 가져오는게 유리
		
		//인터페이스 왜 써야함?
		//설계도, 여러 사람 협업할때.
		//다형성을 위해서도 쓴다.(?)
		
		//service 안쓰는 회사도 있따, dao 만 쓰는 회사도 있다.
		//dao 데이터 베이스와 연결
		//단순 계산하는 logic있을 수 있다. ->service(db없이 할때)
		//그런 개념.

		
		
		//id중복검사하는거(join.html만들다가 옴)
		public String idCheck(String id);
		/*
		select mem_id from member where mem_id='a001';
		--파라미터가 String , 리턴 타입이 String

		select count(*) from member where mem_id='a001';
		--파라미터가 String , 리턴 타입이 int
		 */
		
		
		//우편번호 찾기(join.html만들다가 옴)
		public List<ZipVO> selectByDong(String dong); 
		
		
		//저장가입하기(join.html만들다가 옴)
		public int insertMember(MemberVO vo);
		
		public MemberVO loginSelect(MemberVO vo);

}
