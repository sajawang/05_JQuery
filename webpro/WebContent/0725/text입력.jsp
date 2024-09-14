<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
table{
	border : 1px dotted gold;
}
td{
	width : 200px;
	height : 50px;
	text-align : center;
}
</style>

</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");

	String userName = request.getParameter("name");
	String user = request.getParameter("area");
	
	// user값은 입력시 엔터로 줄을 바꿨다 -\r\n
	// 출력시 줄이 바뀌지 않는다
	
	// \n을 <br>태그로 변경 - replaceAll('old', 'new')
	user = user.replaceAll("\n", "<br>");
	
	
%>

<table border="1">
	<tr>
		<td>이름</td>
		<td><%=userName %></td>

	</tr>
	<tr>
		<td>의견</td>
		<td><%=user %></td>
	</tr>
</table>


</body>


</html>