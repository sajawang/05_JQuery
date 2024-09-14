<%@page import="kr.or.ddit.seria.vo.SeriaVO"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

request.setCharacterEncoding("utf-8");


StringBuffer strbuf = new StringBuffer();
String line = null;

try{
	BufferedReader reader = request.getReader();
	while( (line = reader.readLine() ) !=null){
		strbuf.append(line); //append누적
	}
} catch(Exception e) {
	e.printStackTrace();
}

String reqData = strbuf.toString();//스트링 타입으로 바꾼것
//System.out.print("reqdata= "+reqData);

//역직렬화
Gson gson = new Gson();

//역직렬화 - gson.fromJSON(str,typeclass)

//typeclass에 해당하는 java클래스가 있어야 한다.  
// id, name, email 3가지 속성을 가지고 있는 클래스를 VO클래스로 만든다.

SeriaVO svo = gson.fromJson(reqData, SeriaVO.class); //클래스 타입으로 다시 바꾼것
//setter가 자동 수행
//svo.setId("sdfsdf") svo.setName("sdfadf") svo.setEmail("sdfadf")


//svo로 db연결 - crud처리 -

//svo결과로 응답 데이터를 생성

//gson을 이용할 수 있다. 간단간단밍하게 - 밑에 코딩안하고

%>

{
 "id" : "<%=svo.getId() %>",
 "name" : "<%= svo.getName()%>",
 "email" : "<%= svo.getEmail()%>"
}


















































