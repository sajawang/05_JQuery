<%@page import="kr.or.ddit.mybatis.config.MybatisUtil"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="kr.or.ddit.prod.vo.ProdVO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
//전송데이터 받기 {"prod_id" : "P101000001"}
//1. parameter
//2. reader
StringBuffer strbuf = new StringBuffer(); //한줄씩 읽어온 것을 누적시키기 위함
String line =  null; //한줄씩 읽기 위함

try{
	BufferedReader reader = request.getReader();
	while(true){
		line = reader.readLine();
		if(line==null) break;
		strbuf.append(line);
	}
} catch(Exception e){
	e.printStackTrace();
}

//스트링버퍼에 들어있는것을 다시 문자로 바꾼다.
String reqData = strbuf.toString();

//역직렬화 - 자바객체로
Gson gson = new Gson();
ProdVO vo = gson.fromJson(reqData,ProdVO.class);
//vo.setProd_id("P101000003")

//SqlSession값 얻기
SqlSession sql = MybatisUtil.getSqlSession();

//sql문 실행 - 결과값 얻기
ProdVO pvo = sql.selectOne("prod.prodDetail", vo.getProd_id() );


//결과값을 reequest에 저장-view페이지에서 공유하기 위해서
request.setAttribute("set", pvo);
//이름아무거나 지정하면 되어요


//view페이지로 이동
RequestDispatcher disp = request.getRequestDispatcher("/5-2.제품리스트/prodDetailView.jsp");
disp.forward(request, response);

//prodDetail

%>















































