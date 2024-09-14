package kr.or.ddit.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.BoardServiceimpl;
import kr.or.ddit.board.service.IBoardService;

@WebServlet("/UpdateHit.do")
public class UpdateHit extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//전송데이터 가져오기 - num
		int num = Integer.parseInt(request.getParameter("num"));
		
		
		//service객체 가져오기
		IBoardService service = BoardServiceimpl.getService();
		
		
		//service메소드 호출하기
		int cnt = service.updateHit(num);
		
		
		//request에 저장하기
		request.setAttribute("result", cnt);
		
		
		//view페이지로 이동
		request.getRequestDispatcher("/boardView/result.jsp").forward(request, response);
	}


}
