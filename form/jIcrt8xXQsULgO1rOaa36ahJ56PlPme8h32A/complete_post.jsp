<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="net.kanamic.framework.mail.*"%>
<%@ page import="net.kanamic.framework.validator.*"%>
<%@ page import="net.kanamic.website.request3.*"%>

<% request.setCharacterEncoding("UTF-8"); %>

<%-- メール送信  --%>
<%//入力値Validation
ResultOfValidate vRes = RequestValidationPost.getPackage(request).executeValidate();

//Validate結果で遷移を制御
if(vRes.isValid())
{
	// 送信情報設定
	SimpleSendMailBean mailBean = new SimpleSendMailBean();
//	mailBean.setHost("192.168.1.63");
	mailBean.setHost("192.168.5.100");
	mailBean.setFrom("info@kanamic.net");
	mailBean.setFromName("info");
	mailBean.setTo("shirakawa-t@kanamic.net");
	//mailBean.setTo("hagiwara-m@kanamic.net");
	mailBean.setSubject("【資料郵送】お問合せフォームに登録がありました。");
	mailBean.setText(new RequestMailTextPost(request.getParameterMap()));

    try {
	    //　メール送信
	    SimpleSendMail.Send(mailBean);
	    //　送信が完了したら完了画面に切り替え
//	    RequestDispatcher dipatcher = request.getRequestDispatcher("complete_post_dsp.jsp");
//	    dipatcher.include(request, response);
//	    response.sendRedirect("complete_post_dsp.jsp");
	    response.sendRedirect("https://www.kanamic.net/form/jIcrt8xXQsULgO1rOaa36ahJ56PlPme8h32A/complete_post_dsp.jsp");

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

