<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- 入力データエンコーディング  --%>
<% request.setCharacterEncoding("UTF-8"); %>

<%
	// 表示部の出力
	RequestDispatcher dipatcher = request.getRequestDispatcher("index_dsp.jsp");
	dipatcher.include(request, response);
%>