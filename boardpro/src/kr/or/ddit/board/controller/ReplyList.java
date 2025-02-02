package kr.or.ddit.board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.BoardServiceimpl;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.board.vo.ReplyVO;

/**
 * Servlet implementation class ReplyList
 */
@WebServlet("/ReplyList.do")
public class ReplyList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//전송데이터 받기 //data : {bonum : vidx}
 		int bonum = Integer.parseInt(request.getParameter("bonum"));
 		
		//service객체 얻기
		IBoardService service = BoardServiceimpl.getService();
		
		//service메소드 호출 - 결과값 받기
		List<ReplyVO> list = service.selectByReply(bonum);
		
		//결과값을 저장
		request.setAttribute("list", list);
		
		//view페이지로 이동
		request.getRequestDispatcher("/boardView/replyList.jsp").forward(request, response);
	}

}



















































