package kr.or.ddit.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVO;

@WebServlet("/LogPro.do")
public class LogPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//전송데이터 받기
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		
		MemberVO vo = new MemberVO();
		vo.setMem_id(id);
		vo.setMem_pass(pass);
		
		//service 객체 얻기
		IMemberService service = MemberServiceImpl.getService();
		
		//service 메소드 호출 - 결과값 받기
		MemberVO returnVO = service.loginSelect(vo);
		
		HttpSession session = request.getSession();
		
		//결과값을 저장 - session에 저장
		if(returnVO != null) {
			//로그인 성공
			//session에 저장
			session.setAttribute("loginok", returnVO);
			session.setAttribute("check", "true");
		} else {
			//로그인 실패
			session.setAttribute("check", "false");
		}
		
		//view페이지로 이동 - aaa.jsp - json데이터 생성
		request.getRequestDispatcher("/start/logpro.jsp").forward(request, response);
		
		
	}

}




































