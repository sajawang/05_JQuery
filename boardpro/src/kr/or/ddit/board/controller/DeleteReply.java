package kr.or.ddit.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.BoardServiceimpl;
import kr.or.ddit.board.service.IBoardService;

/**
 * Servlet implementation class DeleteReply
 */
@WebServlet("/DeleteReply.do")
public class DeleteReply extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//전송데이터 - renum 받기
		int renum = Integer.parseInt(request.getParameter("renum"));
		
		//service객체 얻기
		IBoardService service = BoardServiceimpl.getService();
		
		//service메소드 호출
		int cnt = service.deleteReply(renum);
		
		//결과 값 저장하기
		request.setAttribute("result", cnt);
		
		//view페이지로 이동하기
		request.getRequestDispatcher("/boardView/result.jsp").forward(request, response);
		
		
		
		//---------------------------------DeleteBoard 참고하려고 복사함
		//{num:vidx}가 넘어옴
		
		//전송데이터 num
		////int num = Integer.parseInt(request.getParameter("num"));
		
		//service객체 얻기
		////IBoardService service = BoardServiceimpl.getService();
		
		//service메소드 호출
		////int cnt = service.deleteBoard(num);
		
		//결과값 저장
		////request.setAttribute("result", cnt);
		
		//view페이지 가기(고객에게) ( 공통 view페이지 만들어놓음!! flag페이지임 )
		////request.getRequestDispatcher("/boardView/result.jsp").forward(request, response);
	}
}
