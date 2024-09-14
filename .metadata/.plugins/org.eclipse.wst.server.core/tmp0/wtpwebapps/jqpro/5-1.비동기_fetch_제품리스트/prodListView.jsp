<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.or.ddit.prod.vo.ProdVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
//controller에서 저장한 값 꺼내기
List<ProdVO> list = (List<ProdVO>)request.getAttribute("set"); //컨트롤러에서 저장할떄 쓴 이름과 같이 써준다.

//클라이언트 - 비동기처리부분으로 전송(html로 가자아아아ㅏㅏㅏㅏㅏㅏ) - json형태의 문자열로 직렬화한다
//이렇게 하면 한줄로 나와서 불편한다 Gson gson = new Gson();
Gson gson = new GsonBuilder().setPrettyPrinting().create();

String result = gson.toJson(list);
out.print(result);
out.flush();
%>