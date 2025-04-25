<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="net.kanamic.framework.validator.*" %>
<%@ page import="net.kanamic.website.requestSios.*" %>

<% request.setCharacterEncoding("utf-8");//リクエストのキャラクタセット %>

<%  /*** 画面遷移部 ***/

	//画面遷移確認
	String param = request.getParameter(Params.NEXT3);
	if((param != null && param.length() != 0) && Params.NEXT3.equals(param))
	{
	}
	else
	{
	    	//先頭ページへ飛ばす
//	    response.sendRedirect("./index.jsp");
	    response.sendRedirect("https://www.kanamic.net/form/request_sios/index.jsp");
	    	return;
	}

    //入力値Validation
    ResultOfValidate vRes = RequestValidationSios.getPackage(request).executeValidate();

    //Validate結果で遷移を制御
    if(vRes.isValid())
    {
    	//表示部の出力
	    RequestDispatcher rd = request.getRequestDispatcher("./confirm_dsp.jsp");
	    rd.include(request, response);
    }
    else
    {
    	Map<String, String> resMap = new HashMap<String, String>();
    	ResultOfValidate conRes = null;
    	ArrayList resAry = vRes.getResultArray();
        Iterator it = resAry.iterator();
        while(it.hasNext())
        {
        	conRes = (ResultOfValidate)it.next();
        	resMap.put(conRes.getTargetName(),conRes.getMessage());
        }

    	//RequestAttributeにValidate結果オブジェクトをセットする。
    	request.setAttribute("validMap", resMap);
    	//入力画面へ遷移
        RequestDispatcher rd = request.getRequestDispatcher("./input.jsp");
        rd.forward(request, response);
    }
%>

