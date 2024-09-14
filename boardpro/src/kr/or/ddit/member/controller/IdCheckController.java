package kr.or.ddit.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.member.service.MemberServiceImpl;


@WebServlet("/idCheckController.do")
public class IdCheckController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//1-1.전송데이터 받기 - id
		String userId = request.getParameter("id");
		System.out.println(userId);
		
		//1-2.service객체 얻기
		MemberServiceImpl service = MemberServiceImpl.getService();
		
		//2-1.service메소드 호출 - 결과값 얻기
		String resID = service.idCheck(userId);
		
		//2-2.request에 결과값 저장
		request.setAttribute("list", resID);
		
		//3.view페이지로 이동
		request.getRequestDispatcher("/member/idCheck.jsp").forward(request, response);
		
	}


}
