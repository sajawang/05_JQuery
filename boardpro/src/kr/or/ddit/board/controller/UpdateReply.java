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
import kr.or.ddit.board.vo.ReplyVO;


@WebServlet("/UpdateReply.do")
public class UpdateReply extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		//전송데이터 받기 - reply라는 객체로 받았는데, 여기엔 cont, renum이 들어있다
		//reader로 읽어야 하잖아 - 왜?
		//StreamData.java 로 읽으면 된다
		String reqdata = StreamData.dataChange(request); //{"renum" : 5, "cont" : "sdlakjf"} 이런식으로 바꿔주는!
		//StreamData의 리턴타입인 reqdata
		
		//이제는 역직렬화 한다고 했지? vo타입으로 바꿔야겠네?
		Gson gson = new Gson();
		ReplyVO vo= gson.fromJson(reqdata, ReplyVO.class);
		
		//service객체 얻기
		IBoardService service = BoardServiceimpl.getService();
		
		//service메소드 호출
		int cnt = service.updateReply(vo);
		
		//request에 저장하기
		request.setAttribute("result", cnt);
		
		
		//view페이지로 이동
		request.getRequestDispatcher("/boardView/result.jsp").forward(request, response);

		
	}

}
