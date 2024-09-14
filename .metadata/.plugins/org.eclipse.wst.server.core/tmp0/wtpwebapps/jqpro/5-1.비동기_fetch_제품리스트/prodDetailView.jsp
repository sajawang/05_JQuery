<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.or.ddit.prod.vo.ProdVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
//controller에서 저장한 값 꺼내기
ProdVO aaaaaaaaaa = (ProdVO)request.getAttribute("set"); //controller에서 저장한 그 이름을 지정해서 가져온다.

//json형식의 응답데이터를 생성 - 클라이언트 비동기 처리부분으로 전송 - json직렬화
Gson gson = new GsonBuilder().setPrettyPrinting().create();

String bbbbbbbb = gson.toJson(aaaaaaaaaa);
out.print(bbbbbbbb);
out.flush();

%>








































































