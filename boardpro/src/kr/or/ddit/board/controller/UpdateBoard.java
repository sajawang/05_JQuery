package kr.or.ddit.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.ddit.board.service.BoardServiceimpl;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.board.vo.BoardVO;


@WebServlet("/UpdateBoard.do")
public class UpdateBoard extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		//전송데이터 받기
		//받는 방법 read, 어쩌구 해서 받아오죠? 왜??? 언제 해야 하는가
		String reqData = StreamData.dataChange(request);
		//받은것 {content : ... ,subject : ... ,writer : ... ,password,num, mail} 뭐 이런식
		//이제 제이슨 객체 형태가 된것 reqData 
		//그럼 뭘해야해
		
		
		//자바객체로 역직렬화
		//저기서 받은것이 뭘 받은거에여
		//수정에 관한것을 받았다. content,subject,writer,password,num, mail
		Gson gson = new Gson();
		
		//이제 자바 객체로 바꾼것 VO로~~~~~~vo.setnum이런거 사용 가능!!!캬캬캬캬캬캬
		BoardVO vp = gson.fromJson(reqData, BoardVO.class);
		
		//service 객체 얻기
		IBoardService service = BoardServiceimpl.getService();
		
		//service메소드 호출하기 - 결과값 받기
		int cnt = service.updateBoard(vp);
		
		//delete, update, insert에서는 밑에 2가지 단계는 그대로 할그에요
		//1. request에 저장("result"바꾸지 마세여~~)
		//2. view페이지로 이동
		
		
		//request에 저장하기
		request.setAttribute("result", cnt);
				
				
		//view페이지로 이동
		request.getRequestDispatcher("/boardView/result.jsp").forward(request, response);
		
		
		
		
	}

}









































