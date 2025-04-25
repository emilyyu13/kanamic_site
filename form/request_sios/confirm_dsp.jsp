<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- import宣言  --%>
<%@ page import="net.kanamic.framework.util.*"%>
<%@ page import="net.kanamic.website.requestSios.*"%>


<%-- 以下HTML部  --%>
<!DOCTYPE html>
<HTML lang="ja">
<head>  
<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-W54DTMS');</script>
<!-- End Google Tag Manager -->
	  
<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-MZL6ZGP');</script>
<!-- End Google Tag Manager -->

<%@ include file="ga_include.jsp" %>
<meta name="robots" content="noindex, nofollow">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-Language" content="ja" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0">
<meta name="Description" content="カナミックネットワーク介護システムに関するお問合せ、資料請求用フォームのページです。" />
<meta name="copyright" content="http://www.kanamic.net" />
<title>社会的自立支援アウトカム尺度利用申請フォーム | 株式会社カナミックネットワーク</title>
<link rel="start" href="http://www.kanamic.net/" title="Home" />
<link rel="Shortcut Icon" href="http://www.kanamic.net/favicon.ico" type="image/vnd.microsoft.icon" />
<link href="./reset.css" rel="stylesheet" type="text/css" />
<link href="./form_nomenu.css" rel="stylesheet" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>

<body class="confPost">
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-MZL6ZGP"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
	<header>
		<h1>
			<img src="img/logo.png" />
			<img src="img/logokz.png" class="logo2"/>
		</h1>
	</header>
<div id="bredcrumbSec">
		<ul class="pkg" id="breadcrumb">
			<li>規約確認</li>
			<li>使用許諾</li>
			<li>項目の入力</li>
			<li class="now">入力内容の確認</li>
			<li>送信完了</li>
		</ul>
<p>送信内容を確認し、「送信する」ボタンを押してください。</p>
</div>
 <div class="mailForm">
<div class="formBox pkg">
<div class="formLabel">
<label>法人名 </label>
</div>
<div class="formContent">
<p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.SIOS.CORPORATE_NAME)) %></p>
</div>
</div>
<div class="formBox pkg">
<div class="formLabel">
<label>法人名 （フリガナ）</label>
</div>
<div class="formContent">
<p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.SIOS.CORPORATE_NAMEKANA)) %></p>
</div>
</div>
<div class="formBox pkg">
<div class="formLabel">
<label>法人代表者氏名</label>
</div>
<div class="formContent">
<p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.SIOS.REPRESENTATIVE_NAME)) %></p>
</div>
</div>
<div class="formBox pkg">
<div class="formLabel">
<label>法人代表者氏名 （フリガナ）</label>
</div>
<div class="formContent">
<p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.SIOS.REPRESENTATIVE_NAMEKANA)) %></p>
</div>
</div>
<div class="formBox pkg">
<div class="formLabel">
<label>法人電話番号</label>
</div>
<div class="formContent">
<p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.SIOS.CORPORATE_TEL)) %></p>
</div>
</div>
<div class="formBox pkg">
<div class="formLabel">
<label>法人郵便番号</label>
</div>
<div class="formContent">
<p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.SIOS.CORPORATE_ADDNUM)) %></p>
</div>
</div>
<div class="formBox pkg">
<div class="formLabel">
<label>法人住所</label>
</div>
<div class="formContent">
<p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.SIOS.CORPORATE_ADD1)) %></p>
</div>
</div>
<div class="formBox pkg">
<div class="formLabel">
<label>事業所名</label>
</div>
<div class="formContent">
<p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.SIOS.OFFICE_NAME)) %></p>
</div>
</div>
<div class="formBox pkg">
<div class="formLabel">
<label>事業所名 （フリガナ）</label>
</div>
<div class="formContent">
<p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.SIOS.OFFICE_NAMEKANA)) %></p>
</div>
</div>
<div class="formBox pkg">
<div class="formLabel">
<label>事業所種別</label>
</div>
<div class="formContent">
<p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.SIOS.OFFICE_TYPE)) %></p>
</div>
</div>
<div class="formBox pkg">
<div class="formLabel">
<label>事業所番号</label>
</div>
<div class="formContent">
<p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.SIOS.OFFICE_NO)) %></p>
</div>
</div>
<div class="formBox pkg">
<div class="formLabel">
<label>事業所電話番号</label>
</div>
<div class="formContent">
<p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.SIOS.OFFICE_TEL)) %></p>
</div>
</div>
<div class="formBox pkg">
<div class="formLabel">
<label>事業所FAX番号</label>
</div>
<div class="formContent">
<p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.SIOS.OFFICE_FAX)) %></p>
</div>
</div>
<div class="formBox pkg">
<div class="formLabel">
<label>事業所郵便番号</label>
</div>
<div class="formContent">
<p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.SIOS.OFFICE_ADDNUM)) %></p>
</div>
</div>
<div class="formBox pkg">
<div class="formLabel">
<label>事業所住所</label>
</div>
<div class="formContent">
<p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.SIOS.OFFICE_ADD1)) %></p>
</div>
</div>
<div class="formBox pkg">
<div class="formLabel">
<label>ご担当者名 </label>
</div>
<div class="formContent">
<p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.SIOS.CHARGE_NAME)) %></p>
</div>
</div>
<div class="formBox pkg">
<div class="formLabel">
<label>ご担当者名  （フリガナ）</label>
</div>
<div class="formContent">
<p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.SIOS.CHARGE_NAMEKANA)) %></p>
</div>
</div>
<div class="formBox pkg">
<div class="formLabel">
<label>メールアドレス</label>
</div>
<div class="formContent">
<p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.SIOS.MAIL)) %></p>
</div>
</div>
<div class="formBox pkg">
<div class="formLabel">
<label>備考</label>
</div>
<div class="formContent">
<p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.SIOS.BIKO)) %></p>
</div>
</div>


<form name="confirm" action="./complete.jsp" method="post">

 <div class="agreement">

  <div class="submit-container">
  <button class="submit-button" onclick="javascript:ctrlAction('./complete.jsp'); return false;">送信する</button><br><br>
  <button class="back-button" name="<%=Params.BACK %>22" id="<%=Params.BACK %>2"
  value="入力画面に戻る" onclick="javascript:ctrlAction('./input.jsp'); return false;">修正する</button>
  </div>

 </div>
<!-- 引継ぎ情報としてhidden項目を使用する -->
<input type="hidden" name="<%=Params.SIOS.CORPORATE_NAME %>" value="<%=DoText.purgeNull(request.getParameter(Params.SIOS.CORPORATE_NAME)) %>" />
<input type="hidden" name="<%=Params.SIOS.CORPORATE_NAMEKANA %>" value="<%=DoText.purgeNull(request.getParameter(Params.SIOS.CORPORATE_NAMEKANA)) %>" />
<input type="hidden" name="<%=Params.SIOS.REPRESENTATIVE_NAME %>" value="<%=DoText.purgeNull(request.getParameter(Params.SIOS.REPRESENTATIVE_NAME)) %>" />
<input type="hidden" name="<%=Params.SIOS.REPRESENTATIVE_NAMEKANA %>" value="<%=DoText.purgeNull(request.getParameter(Params.SIOS.REPRESENTATIVE_NAMEKANA)) %>" />
<input type="hidden" name="<%=Params.SIOS.CORPORATE_TEL %>" value="<%=DoText.purgeNull(request.getParameter(Params.SIOS.CORPORATE_TEL)) %>" />
<input type="hidden" name="<%=Params.SIOS.CORPORATE_ADDNUM %>" value="<%=DoText.purgeNull(request.getParameter(Params.SIOS.CORPORATE_ADDNUM)) %>" />
<input type="hidden" name="<%=Params.SIOS.CORPORATE_ADD1 %>" value="<%=DoText.purgeNull(request.getParameter(Params.SIOS.CORPORATE_ADD1)) %>" />
<input type="hidden" name="<%=Params.SIOS.OFFICE_NAME %>" value="<%=DoText.purgeNull(request.getParameter(Params.SIOS.OFFICE_NAME)) %>" />
<input type="hidden" name="<%=Params.SIOS.OFFICE_NAMEKANA %>" value="<%=DoText.purgeNull(request.getParameter(Params.SIOS.OFFICE_NAMEKANA)) %>" />
<input type="hidden" name="<%=Params.SIOS.OFFICE_TYPE %>" value="<%=DoText.purgeNull(request.getParameter(Params.SIOS.OFFICE_TYPE)) %>" />
<input type="hidden" name="<%=Params.SIOS.OFFICE_NO %>" value="<%=DoText.purgeNull(request.getParameter(Params.SIOS.OFFICE_NO)) %>" />
<input type="hidden" name="<%=Params.SIOS.OFFICE_TEL %>" value="<%=DoText.purgeNull(request.getParameter(Params.SIOS.OFFICE_TEL)) %>" />
<input type="hidden" name="<%=Params.SIOS.OFFICE_FAX %>" value="<%=DoText.purgeNull(request.getParameter(Params.SIOS.OFFICE_FAX)) %>" />
<input type="hidden" name="<%=Params.SIOS.OFFICE_ADDNUM %>" value="<%=DoText.purgeNull(request.getParameter(Params.SIOS.OFFICE_ADDNUM)) %>" />
<input type="hidden" name="<%=Params.SIOS.OFFICE_ADD1 %>" value="<%=DoText.purgeNull(request.getParameter(Params.SIOS.OFFICE_ADD1)) %>" />
<input type="hidden" name="<%=Params.SIOS.CHARGE_NAME %>" value="<%=DoText.purgeNull(request.getParameter(Params.SIOS.CHARGE_NAME)) %>" />
<input type="hidden" name="<%=Params.SIOS.CHARGE_NAMEKANA %>" value="<%=DoText.purgeNull(request.getParameter(Params.SIOS.CHARGE_NAMEKANA)) %>" />
<input type="hidden" name="<%=Params.SIOS.MAIL %>" value="<%=DoText.purgeNull(request.getParameter(Params.SIOS.MAIL)) %>" />
<input type="hidden" name="<%=Params.SIOS.BIKO %>" value="<%=DoText.purgeNull(request.getParameter(Params.SIOS.BIKO)) %>" />
<input type="hidden" name="<%=Params.NEXT2 %>" value="<%=Params.NEXT2 %>" />
<input type="hidden" name="<%=Params.SEND %>" value="<%=Params.SEND %>" />
</form>
</div>
<!-- Google Code for Lead Conversion Page -->
<script language="javascript" type="text/javascript">
<!--
var google_conversion_id = 1070139595;
var google_conversion_language = "ja";
var google_conversion_format = "1";
var google_conversion_color = "666666";
if (1.0) {
  var google_conversion_value = 1.0;
}
var google_conversion_label = "Lead";
//-->
</script>
<script language="javascript" charset="utf-8">
    var click = false;

    function ctrlAction(strAct)
    {
        if(!click)
        {
            click = true;
            document.forms[0].action=strAct;
            document.forms[0].submit();
        }
    }
</script>
<script language="JavaScript" src="https://www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<img height="1" width="1" src="https://www.googleadservices.com/pagead/conversion/1070139595/?value=1.0&label=Lead&script=0" />
</noscript>

<footer>
 <p><small>Copyright © Kanamic Network Co.,LTD All Rights Reserved.</small></p>
</footer>

</body>
</html>