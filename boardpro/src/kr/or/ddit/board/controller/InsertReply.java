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

@WebServlet("/InsertReply.do")
public class InsertReply extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertReply() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//원래 데이터 받을 때 
		//stringbuffer
		//reader.readLine
		//buffer에 line을 추가한다
		//가져온게 찍히고 return
		
		request.setCharacterEncoding("utf-8");
		
		//전송데이터 받기
		String reqData = StreamData.dataChange(request);
		
		//역직렬화. String으로된 json이니까 -> 자바 객체로 바꾸기
		Gson gson = new Gson();
		ReplyVO rvo = gson.fromJson(reqData, ReplyVO.class);
		
		//service객체 얻기
		IBoardService service = BoardServiceimpl.getService();
		
		//service메소드 호출 
		int cnt = service.insertReply(rvo);
		System.out.println(cnt);
		//request에 결과값을 저장
		//동기방식과 비동기 방식이 다르다 이부분
		request.setAttribute("result", cnt);
		
		//view페이지로 이동
		request.getRequestDispatcher("/boardView/result.jsp").forward(request, response);
	}

}
