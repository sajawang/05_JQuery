<%@page import="kr.or.ddit.lprod.vo.LprodVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.mybatis.config.MybatisUtil"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	//전송데이터 가져오기
	
	//SqlSession 얻어오기 - MybatisUtil - 이유 : sql문을 수행하기 위해(mapper에 sql들ㅇㅓ있음)
	SqlSession sql = MybatisUtil.getSqlSession();
	
	//mapper수행
	List<LprodVO> list = sql.selectList("lprod.getAllLprod");
	
	//결과로 json데이터 형식으로 응답 전송데이터 생성
	//결과를 저장하고 view페이지로 forward시킨다
	 
	request.setAttribute("set", list);
	RequestDispatcher disp = request.getRequestDispatcher("/5-2.제품리스트/lprodView.jsp");
	disp.forward(request, response);

%>