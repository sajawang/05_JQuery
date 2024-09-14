package kr.or.ddit.board.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.ddit.board.service.BoardServiceimpl;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PListVO;
import kr.or.ddit.board.vo.PageVO;

/**
 * Servlet implementation class BoardList
 */
@WebServlet("/boardList.do")
public class BoardList extends HttpServlet {

	
	//get인지 post인지 모를때 service로 해보자
	//->공유폴더에 StreamData를 넣었다.controller 패키지에
	//dataChange메소드 String으로 마꾸어서 requdata ,  reader로 읽을때 항상 과정 똑같아서 메소드로 만든것
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		//전송데이터 가져오기 - 페이지 번호 page, stype, sword(String으로 가져온다)
		String reqData = StreamData.dataChange(request); //dataChange에 request를 파라미터로 넘겨준다.
		//reqData엔 어떤식의 데이터가 들어있을까요?
		//{"page":"1", "stype":"", "sword":""}
						//stype,sword엔 처음엔 아무것도 없다
		//{  }는 ajax에서 올거다
		
		
		//{   }이런 애를 역직렬화 한다. - 이를 위해 PlistVO를 하나 만들게여(3개 들어갈거에여)
		Gson gson = new Gson();
		PListVO vo = gson.fromJson(reqData, PListVO.class); //reqData를 PListVO클래스 타입으로 바꾼다
															// json형식을 자바객체 형식으로 바꾼다는 뜻
		//PListVO vo 이 속엔 vo.setPage(1) vo.setStype("") vo.setSword("") 처음에는 아무것도 없는 애들이 들어있다.
		
		//Service에 들어있는 pageInfo를 이제 호출해야함
		//service객체 얻기
		IBoardService service = BoardServiceimpl.getService();
		//PageVO pvo = service.pageInfo(page, stype, sword);
		//								이 안에 들어있는 데이터의 형태는  vo.setPage(1) vo.setStype("") vo.setSword("")이렇게 들어있기에
		//list를 위한 page정보 가져오기
		PageVO pvo = service.pageInfo( vo.getPage(), vo.getStype(), vo.getSword());
		//start, end, startPage, endPage, totalPage
		
		//list가져오기
		//list가져오기하ㄹ때 mapper관찰
		//map에다가 #start, #end넣어주고 dynamicCondition에 sword stype올수 있으니까 모두 map에 넣어준다
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", pvo.getStart()); //이 맵의 키값은 mapper의 #start, dynamicCondition이런 애들에 들어있따.
		map.put("end", pvo.getEnd());
		map.put("stype", vo.getStype());//초기값이 없으므로 mapper에서 dynamicCondition처음엔 실행 안됨
		map.put("sword", vo.getSword());
		
		
		System.out.println(pvo.getEnd());
		//list가져오기 - 메소드 호출
		List<BoardVO> list = service.selectBoardList(map);
		System.out.println(list);
		
		//결과값을 request에 저장
		request.setAttribute("list", list);
		request.setAttribute("startPage", pvo.getStartPage());
		request.setAttribute("endPage", pvo.getEndPage());
		request.setAttribute("totalPage", pvo.getTotalPage());
		
		//마지막 페이지에는 next버튼이 없다
		// Previous 3 4 Next 이런식의 화면구성에서
		
		//view페이지로 이동
		request.getRequestDispatcher("/boardView/list.jsp").forward(request, response);
	}
	

}


















