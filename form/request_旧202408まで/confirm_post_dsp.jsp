<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- import宣言  --%>
<%@ page import="net.kanamic.framework.util.*"%>
<%@ page import="net.kanamic.website.request3.*"%>


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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-Language" content="ja" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0">
<meta name="Description" content="カナミックネットワーク介護システムに関するお問合せ、資料請求用フォームのページです。" />
<meta name="copyright" content="http://www.kanamic.net" />
<title>資料請求・お問合せフォーム | 株式会社カナミックネットワーク</title>
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
 <h1><img src="img/logo.png" /></h1>
</header>
<div id="bredcrumbSec">
<ul class="pkg" id="breadcrumb">
 <li><span class="itemNum">1</span>項目の入力</li>
 <li class="now"><span class="itemNum">2</span>入力内容の確認</li>
 <li><span class="itemNum">3</span>送信完了</li>
</ul>
<p>送信内容を確認し、「送信する」ボタンを押してください。</p>
</div>
 <div class="mailForm">
  <div class="formBox pkg corporateName">
   <div class="formLabel">
    <label for="corporateName">法人名</label>
    <span class="required">必須</span>
   </div>
   <div class="formContent">
    <p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.POST.CORPORATENAME)) %></p>
   </div>
  </div>
 <div class="formBox pkg yourName">
   <div class="formLabel">
    <label for="yourName">ご担当者名</label>
    <span class="required">必須</span>
   </div>
   <div class="formContent">
    <p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.POST.CHARGENAME)) %></p>
   </div>
 </div>
 <div class="formBox pkg mailAddress">
   <div class="formLabel">
    <label for="mailAddress">メールアドレス</label>
   </div>
   <div class="formContent">
    <p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.POST.MAIL)) %></p>
   </div>
 </div>
 <div class="formBox pkg phoneNumber">
   <div class="formLabel">
    <label for="phoneNumber">電話番号</label>
    <span class="required">必須</span>
   </div>
   <div class="formContent">
    <p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.POST.TEL)) %></p>
   </div>
 </div>
 <div class="formBox pkg postalCode">
   <div class="formLabel">
    <label for="postalCode">郵便番号</label>
    <span class="required">必須</span> </div>
   <div class="formContent pkg">
    <p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.POST.ADDNUM)) %></p>
   </div>
 </div>
 <div class="formBox pkg address">
   <div class="formLabel">
    <label for="postalCodeReqPost">住所</label>
    <span class="required">必須</span> </div>
   <div class="formContent">
    <p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.POST.ADD1)) %></p>
   </div>
 </div>
 <div class="formBox pkg formSubject">
   <div class="formLabel pkg">
    <label for="formSubject">お問い合せ内容</label>
   </div>
   <div class="formContent">
    <p class="entryChk"><%=DoText.purgeNull(request.getParameter(Params.POST.INQUIRY)) %></p>
   </div>
 </div>
 <div class="formBox pkg prvInfo">
   <div class="formLabel">
    <label for="prvInfo">個人情報の取扱</label>
    <span class="required">必須</span>
   </div>
   <div class="formConfirm">
    <p class="entryChk">同意します</p>
   </div>
 </div>
<form name="confirm" action="./complete.jsp" method="post">

 <div class="agreement">

  <div class="submit-container">
  <button class="submit-button" onclick="javascript:ctrlAction('./complete_post.jsp'); return false;">送信する</button><br><br>
  <button class="back-button" name="<%=Params.BACK %>22" id="<%=Params.BACK %>2"
  value="入力画面に戻る" onclick="javascript:ctrlAction('./input.jsp'); return false;">修正する</button>
  </div>

 </div>
<!-- 引継ぎ情報としてhidden項目を使用する -->
<input type="hidden" name="<%=Params.POST.CORPORATENAME %>"
  value="<%=DoText.purgeNull(request.getParameter(Params.POST.CORPORATENAME)) %>" />
<input type="hidden" name="<%=Params.POST.CHARGENAME %>"
  value="<%=DoText.purgeNull(request.getParameter(Params.POST.CHARGENAME)) %>" />
<input type="hidden" name="<%=Params.POST.MAIL %>"
  value="<%=DoText.purgeNull(request.getParameter(Params.POST.MAIL)) %>" />
<input type="hidden" name="<%=Params.POST.TEL %>"
  value="<%=DoText.purgeNull(request.getParameter(Params.POST.TEL)) %>" />
<input type="hidden" name="<%=Params.POST.ADDNUM %>"
  value="<%=DoText.purgeNull(request.getParameter(Params.POST.ADDNUM)) %>" />
<input type="hidden" name="<%=Params.POST.ADD1 %>"
  value="<%=DoText.purgeNull(request.getParameter(Params.POST.ADD1)) %>" />
<input type="hidden" name="<%=Params.POST.INQUIRY %>"
  value="<%=DoText.purgeNull(request.getParameter(Params.POST.INQUIRY)) %>" />
<input type="hidden" name="<%=Params.MAIL_REC_KBN %>"
  value="<%=DoText.purgeNull(request.getParameter(Params.MAIL_REC_KBN)) %>" />
</form>
<script language="javascript">
<!-- Overture Services Inc. 07/15/2003
var cc_tagVersion = "1.0";
var cc_accountID = "3578720530";
var cc_marketID =  "4";
var cc_protocol="http";
var cc_subdomain = "convctr";
if(location.protocol == "https:")
{
    cc_protocol="https";
     cc_subdomain="convctrs";
}
var cc_queryStr = "?" + "ver=" + cc_tagVersion + "&aID=" + cc_accountID + "&mkt=" + cc_marketID +"&ref=" + escape(document.referrer);
var cc_imageUrl = cc_protocol + "://" + cc_subdomain + ".overture.com/images/cc/cc.gif" + cc_queryStr;
var cc_imageObject = new Image();
cc_imageObject.src = cc_imageUrl;
// -->
</script>
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