package kr.or.ddit.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVO;

/**
 * Servlet implementation class InsertMember
 */
@WebServlet("/insertMember.do")
public class InsertMember extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertMember() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//한글처리를 먼저..
		request.setCharacterEncoding("utf-8");
		
		//전송데이터 받기
		String reqData = StreamData.dataChange(request);
		
		//역직렬화(자바 객체로 다시 바꾼다. MemberVO타입으로)
		Gson gson = new Gson();
		MemberVO vo = gson.fromJson(reqData, MemberVO.class);
			//수행결과 -> vo.setMem_id("korea") vo.setMem_name("sdsdsd")
		
		//service객체 얻기
		IMemberService service = MemberServiceImpl.getService();
		
		//service메소드 호출 - 결과값 받기
		int cnt = service.insertMember(vo);
		
		//결과값을 저장
		request.setAttribute("result", cnt);
		
		//view페이지로 이동 - 응답데이터 생성
		//????????????????????????view로 왜가지
		request.getRequestDispatcher("/member/insert.jsp").forward(request, response);
	}

}





















