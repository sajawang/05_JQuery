<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
p{
 font-size : 2.0rem;
} 
</style>

<%

request.setCharacterEncoding("UTF-8");

//name, tel입력한(전송) 값 받기
String userName = request.getParameter("name");
String userTel = request.getParameter("tel");

//전송된 값으로 db연결하여 CRUD처리를 한다
//처리된 결과를 가지고 응답 페이지를 생성한다- text,html,xml,json
%>

<p>이름 : <%= userName %></p>
<p>전화번호 : <%= userTel %></p>