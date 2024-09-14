<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
h1{
	color : red;
}
p{
	font-size : 1.2rem;
}
h1,p{
	border : 1px solid;
	margin : 10px;
	padding : 5px;
}
.a{

}

</style>


</head>
<body>
<h1 class="a">JSP : JAVA SERVER PAGE</h1>
<p class="a">html과 java 코드를 같이 사용할 수 있다.</p>
<p class="a">자바코드는 &lt;%    %&lt; 기호 내부에 기술한다.</p>
<p class="a">자바에서 처리한 결과를 출력하기 위해서는 &lt;%=  %&lt; 기호 내부에 기술한다</p>

<%

	//post전송시 한글깨짐 방지
	request.setCharacterEncoding("UTF-8");

	//입력한 id, name, pass를 가져온다 - request(요청)객체 이용
	String userId = request.getParameter("id");
	String userName = request.getParameter("name");
	String userPass = request.getParameter("pass");
	
	
	//db에 저장 되어 있는지 검사

	//결과를 client에 응답 - reponse객체 이용 - 출력할 내용을 만든다
	
%>

<!-- 자바에서 처리한 결과를 출력 table, div -->
<%= userId %><br>
<%= userName %><br>
<%= userPass %><br>

</body>
</html>

















