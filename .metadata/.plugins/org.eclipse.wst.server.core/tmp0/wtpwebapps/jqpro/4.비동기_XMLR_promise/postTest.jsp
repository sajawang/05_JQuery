<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


request.setCharacterEncoding("UTF-8");

<%
//전송 데이터 방기 - name, id
String userName = request.getParameter("name");
String userId = request.getParameter("id");

//DB연결해서 CRUD처리 결과값 얻기

//결과값으로 응답 데이터를 생성

%>

<%-- 
parsing 안했으면 얘를 쓸 수 있음
text/html html코드로 응답받았을때

getData('postTest.jsp',params)
		 .then(res=>{
		 $('#result1').html(res);
		 })


<p><%=userName%>님 환영합니다</p>
<p><%=userId%>라 부를</p>


--%>

<%--parse했을 때는 {} 얘가 대상임
응답 데이터를 html코드로 응답받아서 스크립트 객체로 prasing함

getData('postTest.jsp',params)
		 .then(res=>{
			 return JSON.parse(res);
		 })
		 .then( (data) =>{
			 let code = `<p> 이름 : ${data.name}</p>
			 			 <p> 아이디 : ${data.id}</p>`;
 			 $('#result1').html(code);
		 }) 
		 
		 
 --%>

{

 "name" : "<%= userName %>",
 "id"   : "<%= userId %>"
 
}

    