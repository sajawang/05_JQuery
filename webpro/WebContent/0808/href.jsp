<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
h1{

}
h3{
	color : blue;
}
</style>
</head>
<body>
<h1>JSP : Java Server Page</h1>

<%

String userName = request.getPararmeter("id");

%>

<h3><% userName %>님 환영합니다</h3>
</body>
</html>














