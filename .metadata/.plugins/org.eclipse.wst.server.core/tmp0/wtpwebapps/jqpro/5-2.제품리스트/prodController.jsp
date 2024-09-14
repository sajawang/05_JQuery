<%@page import="javax.servlet.RequestDispatcher"%>
<%@page import="kr.or.ddit.prod.vo.ProdVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.mybatis.config.MybatisUtil"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="kr.or.ddit.lprod.vo.LprodVO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
//전송데이터 받기 {"lprod_gu" : "P101"}
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

//역직렬화- 다시 자바 객체로 바꾼다. - lprod_gu속성을 가지고 있는 자바 객체 - LprodVO
Gson gson = new Gson();
LprodVO vo = gson.fromJson(reqData, LprodVO.class);
//vo.setLprod_gu("P101")이렇게 자동으로 설정 된그에요

//SqlSession얻기
SqlSession sql = MybatisUtil.getSqlSession();


//sql실행 - 결과 값 얻기
List<ProdVO> list = sql.selectList("prod.selectByLgu",vo.getLprod_gu());

//request에 저장
request.setAttribute("set",list);//?????????????????????????????????setAttribute의 첫번째 인자는 누구꺼야
		//오잉 처음 나온거 같은데!!!!
		//jsp파일로 넘어간듯?


//결과값을 가지고 view페이지로 이동
RequestDispatcher disp = request.getRequestDispatcher("/5-2.제품리스트/prodListView.jsp");
disp.forward(request,response);
%>










































