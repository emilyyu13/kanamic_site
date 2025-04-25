<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="net.kanamic.framework.mail.*"%>
<%@ page import="net.kanamic.framework.validator.*"%>
<%@ page import="net.kanamic.website.requestSios.*"%>

<% request.setCharacterEncoding("UTF-8"); %>

<%
//画面遷移確認
String param = request.getParameter(Params.SEND);
if((param != null && param.length() != 0) && Params.SEND.equals(param))
{
}
else
{
    	//先頭ページへ飛ばす
//    response.sendRedirect("./index.jsp");
    response.sendRedirect("https://www.kanamic.net/form/request_sios/index.jsp");
    	return;
}

%>
<%-- メール送信  --%>
<%//入力値Validation
ResultOfValidate vRes = RequestValidationSios.getPackage(request).executeValidate();

//Validate結果で遷移を制御
if(vRes.isValid())
{
	//TODO mailBeanが宛先一つしか指定できないので、２回送っている

	// 送信情報設定
	SimpleSendMailBean mailBean = new SimpleSendMailBean();
//	mailBean.setHost("192.168.1.63");
	mailBean.setHost("192.168.5.100");
	mailBean.setFrom("info@kanamic.net");
	mailBean.setFromName("info");
//	mailBean.setTo("toiawase@kanamic.net");
//	mailBean.setTo("hagiwara-m@kanamic.net");
	mailBean.setTo("sios@kanamic.net");
	mailBean.setSubject("【無料版社会的自立支援アウトカム尺度】申請がありました。");
	mailBean.setText(new RequestMailTextSios(request.getParameterMap()));

	SimpleSendMailBean mailBean2 = new SimpleSendMailBean();
	mailBean2.setHost("192.168.5.100");
	mailBean2.setFrom("info@kanamic.net");
	mailBean2.setFromName("info");
	mailBean2.setTo("info@kaedenokaze.com");
	mailBean2.setSubject("【無料版社会的自立支援アウトカム尺度】申請がありました。");
	mailBean2.setText(new RequestMailTextSios(request.getParameterMap()));
    try {
	    //　メール送信
	    SimpleSendMail.Send(mailBean);
	    SimpleSendMail.Send(mailBean2);
	    //　送信が完了したら完了画面に切り替え

//	    response.sendRedirect("complete_dsp.jsp");
//	    response.sendRedirect("https://www.kanamic.net/form/request_sios/complete_dsp.jsp");
	    RequestDispatcher rd = request.getRequestDispatcher("./complete_dsp.jsp");
	    rd.include(request, response);
	} catch (Exception e) {
	    //　送信が失敗したら？？？
	    e.printStackTrace();
	}
}else
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

