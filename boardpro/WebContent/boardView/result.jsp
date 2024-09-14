<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

//insert, delete, update에서는 이걸 공통view로 쓰겠다. 
//controller에서 꼭 "result"로 꺼내야함
//controller에서 저장한 값 꺼내기
int cnt = (int)request.getAttribute("result");

if(cnt>0){%>

	{
		"flag" : "ok"
	
	}	
<%} else {%>


	{
		"flag" : "no"
	}
<%	
}
%>    
    