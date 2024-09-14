<%@page import="com.google.gson.JsonElement"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="kr.or.ddit.board.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//controller에서 저장한 값 꺼내기
List<BoardVO> list = (List<BoardVO>)request.getAttribute("list");
int startPage=(int)request.getAttribute("startPage");
int endPage=(int)request.getAttribute("endPage");
int totalPage=(int)request.getAttribute("totalPage");

//json형태로 만드는 과정
JsonObject obj = new JsonObject();
obj.addProperty("sp", startPage);
obj.addProperty("ep", endPage);
obj.addProperty("tp", totalPage);
//{"sp" : "1", "ep" : "2", "tp" : "3"} 여기까지 만든것

Gson gson = new Gson();
JsonElement elList = gson.toJsonTree(list);
obj.add("datas", elList);	//아래에 "datas"에 [...]  대괄호 안의 값을 넣은것
out.print(obj);
out.flush();
 //{
	//"sp" : "1", "ep" : "2", "tp" : "3",
	//"datas" : [
	         //  {
	        //	   "num"  : "20",
	        //        "writer" :  "작성자20",
	       	//		"subject" : "제목20",
	       	//		"content" : "내용20"
	         //  },
	         //  {
	        //	   "num"  : "19",
	         //       "writer" :  "작성자19",
	       	//		"subject" : "제목19",
	       		//	"content" : "내용19"
	        //   },
	         //  {
	        //	   "num"  : "18",
	         //       "writer" :  "작성자18",
	       	//		"subject" : "제목18",
	       	//		"content" : "내용18"
	         //  }
	   //]
 //} 
%>