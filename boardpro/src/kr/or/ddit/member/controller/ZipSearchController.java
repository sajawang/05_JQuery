package kr.or.ddit.member.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.ZipVO;


@WebServlet("/zipSearch.do")
public class ZipSearchController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		
		//전송데이터 받기
		String dongValue = request.getParameter("dong");
		
		//service 객체 얻기
		MemberServiceImpl service = MemberServiceImpl.getService();
		
		//service메소드 호출-결과값받기
		 List<ZipVO> list = service.selectByDong(dongValue);
		 
		//request에 저장
		request.setAttribute("list", list);
		
		//view페이지 간다
		request.getRequestDispatcher("member/dongList.jsp").forward(request, response);
	}

}
