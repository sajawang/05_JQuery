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
import kr.or.ddit.member.controller.StreamData;


@WebServlet("/InsertBoard.do")
public class InsertBoard extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String reqData = StreamData.dataChange(request);
		//json형태  {writer: '김은대', subject: '123', mail: '1231', password: '123', content: '12312312313'}
		//직렬화해서 보냈기때문에 "{...}"이렇게 묶여있는 상태
		
		//자바객체로 역직렬화 BoardVO형태로
		Gson gson = new Gson();
		BoardVO vo = gson.fromJson(reqData, BoardVO.class);
		//vo.setWriter("김은대"),mail, subject, password, content
		//저장할때 필요한게 하나 있다 그랬어
		//wip
		//hit은 mapper에서 0 줬죠
		
		vo.setWip(request.getRemoteAddr()); //글쓴 사람의 ip를 서버에 저장하려 한다. //예시) 네이버 서버에 글쓰면
		
		//service객체 얻기
		IBoardService service = BoardServiceimpl.getService();
		
		//service메소드 호출
		int cnt = service.insertBoard(vo);
				
		//결과값 저장-result로 해주세요!~~
		request.setAttribute("result", cnt);
		
		//view
		request.getRequestDispatcher("/boardView/result.jsp").forward(request, response);
		
		
		
	}

}
