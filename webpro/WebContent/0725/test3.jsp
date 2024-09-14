<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
h1{
	color : blue;
}
table{
	border : 1px dotted gold;
}
td{
	width : 200px;
	height : 50px;
	text-align : center;
}
.title{
 	background : orange;
}
.res{
	wiedth : 500px;
}
</style>
</head>
<body>

<%

	request.setCharacterEncoding("UTF-8");

	String userId = request.getParameter("id");
	String userName = request.getParameter("name");
	String userPass = request.getParameter("pass");
	
	String userFile = request.getParameter("file");
	
	String todos[] = request.getParameterValues("todo");
	
	String str="";
	
	/* for(int i=0; i<todos.length; i++){
		str+=todos[i]+"&nbsp;&nbsp;&nbsp;";
	} */
	
	for(String todo : todos){
		str+=todo+"&nbsp;&nbsp;&nbsp;";
	}
	
%>

<table border="1">
	<tr>
		<td class="title">아이디</td>
		<td class="res"><%=userId %></td>
	</tr>

	<tr>
		<td class="title">이름</td>
		<td class="res"><%=userName %></td>
	</tr>
		
	<tr>
		<td class="title">비밀번호</td>
		<td class="res"><%=userPass %></td>
	</tr>

	<tr>
		<td class="title">첨부파일</td>
		<td class="res"><%=userFile %></td>

	</tr>
	<tr>
		<td class="title">할일</td>
		<td class="res"><%=str %></td>
	</tr>
</table>


</body>
</html>