<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="net.kanamic.website.requestSios.*" %>

<% request.setCharacterEncoding("utf-8");//リクエストのキャラクタセット %>

<%  /*** 画面遷移部 ***/

	//画面遷移確認
	String param = request.getParameter(Params.NEXT1);
    if((param != null && param.length() != 0) && Params.NEXT1.equals(param))
    {
    		//表示部の出力
	    RequestDispatcher rd = request.getRequestDispatcher("./agreement_dsp.jsp");
	    rd.include(request, response);
    }
    else
    {
	    	//先頭ページへ飛ばす
//        response.sendRedirect("./index.jsp");
        response.sendRedirect("https://www.kanamic.net/form/request_sios/index.jsp");
    }
%>
