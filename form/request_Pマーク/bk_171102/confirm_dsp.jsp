<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- import宣言  --%>
<%@ page import="net.kanamic.framework.util.*"%>
<%@ page import="net.kanamic.website.request.*"%>


<%-- 以下HTML部  --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ja" lang="ja" dir="ltr">
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

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-Language" content="ja" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="Description" content="カナミックネットワーク介護システムに関するお問合せ、資料請求用フォームのページです。" />

<meta name="copyright" content="http://www.kanamic.net" />
<title>内容の確認 - 資料請求・お問合せフォーム | 株式会社カナミックネットワーク</title>
<link rel="start" href="https://www.kanamic.net/" title="Home" />
<link rel="Shortcut Icon" href="https://www.kanamic.net/favicon.ico" type="image/vnd.microsoft.icon" />
<link href="../common/css/import.css" rel="stylesheet" type="text/css" media="screen,tv" />
<link href="../common/css/print.css" rel="stylesheet" type="text/css" media="print" />
<script type="text/javascript" src="../common/js/geometry.js"></script>
<script type="text/javascript" src="../common/js/jquery-1.2.3.pack.js"></script>
<script type="text/javascript" src="../common/js/jquery-accordion.js"></script>
<script type="text/javascript" src="../common/js/thickbox-3.1.js"></script>
<script type="text/javascript" src="../common/js/yuga-0.6.1.js"></script>
<script type="text/javascript" src="../common/js/swfobject.js"></script>
<script type="text/javascript" src="../common/js/ll.js"></script>
<script type="text/javascript" src="../common/js/addLayer.js"></script>
<script type="text/javascript" src="../common/js/heightLine.js"></script>
<script type="text/javascript" src="../common/js/jquery.droppy.js"></script>
<!--[if IE 6]>
<script type="text/javascript" src="../common/js/DD_belatedPNG_0.0.8a-min.js"></script>
<script>DD_belatedPNG.fix('.png_bg,.iepngfix');</script>
<![endif]-->
</head>

<body id="inquiry">
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-MZL6ZGP"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-462660-7', 'auto');
  ga('send', 'pageview');

</script>
<div id="container">
<div id="containerInner">
<div id="headingBg">
<div class="titleBg">
<h1 title=""><img src="../common/img/inquiry/h1_inquiry.png" alt="資料請求・お問合せ" width="284" height="31" class="png_bg" title="資料請求・お問合せ" /></h1></div>
</div>
<div id="pagebgTop" class="png_bg"></div>
<div id="pageBody" class="pkg png_bg">


<div id="primary" class="cl">


<ul id="topicPath" class="pkg">
<li><a href="https://www.kanamic.net/">ホーム</a></li>
<li>資料請求・お問合せ</li>
</ul>




<form name="confirm" action="./complete.jsp" method="post">
<div class="section">
<h2 class="caution tc mb10">※まだ資料請求は完了しておりません。</h2>
<h2><img src="../common/img/inquiry/h2_inquiry03_02.gif" alt="送信内容確認画面" width="600" height="38" title="内容の確認" /></h2>
<p>入力内容をご確認のうえ、よろしければ<span style="font-weight:bold">「この内容で送信する」</span>ボタンをクリックしてください。</p>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="inquiryTable" summary="カナミックネットワーク資料請求・お問合せフォーム">

<tr>
<th scope="row">ご法人名</th>
<td><%=DoText.purgeNull(request.getParameter(Params.CORPORATENAME)) %></td>
</tr>
<tr>
<th scope="row">ご担当者名</th>
<td><%=DoText.purgeNull(request.getParameter(Params.CHARGENAME)) %></td>
</tr>
<tr>
<th scope="row">郵便番号</th>
<td><%=DoText.purgeNull(request.getParameter(Params.ADDNUM)) %><br /></td>
</tr>
<tr>
<th scope="row">ご住所</th>
<td><%=DoText.purgeNull(request.getParameter(Params.ADD1)) %><br />
<%=DoText.purgeNull(request.getParameter(Params.ADD2)) %></td>
</tr>
<tr>
<th scope="row">電話番号</th>
<td><%=DoText.purgeNull(request.getParameter(Params.TEL)) %></td>
</tr>
<tr>
<th scope="row">FAX番号</th>
<td><%=DoText.purgeNull(request.getParameter(Params.FAX)) %><br /></td>
</tr>
<tr>
<th scope="row">E-Mail</th>
<td><%=DoText.purgeNull(request.getParameter(Params.MAIL)) %><br /></td>
</tr>
<!-- 
<tr>
<th scope="row">資料請求</th>
<td><%=DoText.purgeNull(request.getParameter(Params.SIRYOU)) %></td>
</tr>
 -->
<tr>
<th scope="row">ご希望の資料</th>
<td><%if (!DoText.purgeNull(request.getParameter(Params.HAM)).equals("")) { %>
HAMシステム(訪問介護/通所介護/福祉用具/GH/訪問看護/訪問入浴/障害者総合支援/通所リハビリ/小規模多機能型生活介護/特定施設[有料老人ホーム]/夜間対応訪問介護/自費サービス)<br />
<%} %>
<%if (!DoText.purgeNull(request.getParameter(Params.CIC)).equals("")) { %>
CICシステム（居宅介護支援/地域包括支援）<br />
<%} %>
<%if (!DoText.purgeNull(request.getParameter(Params.TRITRUS)).equals("")) { %>
TRITRUSシステム（ショートステイ/老人福祉施設/老人保健施設）
<%} %>
</td>
</tr>
<tr>
<th scope="row">お問合せ内容</th>
<td><pre><%=DoText.purgeNull(request.getParameter(Params.INQUIRY)) %></pre></td>
</tr>
<tr>
<th scope="row">個人情報の取り扱いについて</th>
<td>株式会社カナミックネットワーク｢個人情報保護に関して｣に同意する。</td>
</tr>
</table>
<!-- 
<p class="nextScreen tc">
<input type="button" name="<%=Params.BACK %>" id="back"
	value="入力画面に戻る" onclick="javascript:ctrlAction('./input.jsp');" />
<input type="button" name="<%=Params.SEND %>" id="send"
	value="この内容で送信する" onclick="javascript:ctrlAction('./complete.jsp');" />
</p>
 -->
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="confirmData">
<tr>
<td width="33%" align="left">&nbsp;</td>
<td width="34%" align="left"><img src="../common/img/inquiry/soushin.gif" alt="この内容で送信する" width="212" height="38" class="btn" onclick="javascript:ctrlAction('./complete.jsp');"/></td>
<td width="33%" align="right" valign="bottom"><input type="button" name="<%=Params.BACK %>22" id="<%=Params.BACK %>2"
	value="入力画面に戻る" onclick="javascript:ctrlAction('./input.jsp');" /></td>
</tr>
</table>
<p class="caution tc mb10">▲<br />
このボタンを押して資料請求は完了です。</p>

<!-- // end .section =============================--></div>
<!-- 引継ぎ情報としてhidden項目を使用する -->
<input type="hidden" name="<%=Params.CORPORATENAME %>"
	value="<%=DoText.purgeNull(request.getParameter(Params.CORPORATENAME)) %>" />
<input type="hidden" name="<%=Params.CHARGENAME %>"
	value="<%=DoText.purgeNull(request.getParameter(Params.CHARGENAME)) %>" />
<%-- //TODO:20091126 narita 資料請求フォーム改修 資料請求チェックボックスの削除	TODO:20091203　narita 資料請求フォーム改修2 資料請求復活 --%>
	
<input type="hidden" name="<%=Params.HAM %>"
	value="<%=DoText.purgeNull(request.getParameter(Params.HAM)) %>" />
<input type="hidden" name="<%=Params.CIC %>"
	value="<%=DoText.purgeNull(request.getParameter(Params.CIC)) %>" />
<input type="hidden" name="<%=Params.TRITRUS %>"
	value="<%=DoText.purgeNull(request.getParameter(Params.TRITRUS)) %>" />

<input type="hidden" name="<%=Params.ADDNUM %>"
	value="<%=DoText.purgeNull(request.getParameter(Params.ADDNUM)) %>" />
<input type="hidden" name="<%=Params.ADD1 %>"
	value="<%=DoText.purgeNull(request.getParameter(Params.ADD1)) %>" />
<input type="hidden" name="<%=Params.ADD2 %>"
	value="<%=DoText.purgeNull(request.getParameter(Params.ADD2)) %>" />
<input type="hidden" name="<%=Params.TEL %>"
	value="<%=DoText.purgeNull(request.getParameter(Params.TEL)) %>" />
<input type="hidden" name="<%=Params.FAX %>"
	value="<%=DoText.purgeNull(request.getParameter(Params.FAX)) %>" />
<input type="hidden" name="<%=Params.MAIL %>"
	value="<%=DoText.purgeNull(request.getParameter(Params.MAIL)) %>" />
<%-- //TODO:20091126 narita 資料請求フォーム改修 資料請求項目の追加	--%>
<input type="hidden" name="<%=Params.SIRYOU %>"
	value="<%=DoText.purgeNull(request.getParameter(Params.SIRYOU)) %>" />
<input type="hidden" name="<%=Params.INQUIRY %>"
	value="<%=DoText.purgeNull(request.getParameter(Params.INQUIRY)) %>" />
<%-- //TODO:20091126 narita 資料請求フォーム改修 個人情報取り扱い項目の追加	--%>
<input type="hidden" name="<%=Params.AGREE %>"
	value="<%=DoText.purgeNull(request.getParameter(Params.AGREE)) %>" />
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



<p class="returnToTop"><a href="#container">このページのトップへ</a></p>

<!--<div id="flashContent2">
<div class="noFlashNoScript">
<dl class="pkg">
<dt>お使いのパソコンにはFLASH PLAYERが入ってないかJavaScriptが有効になっていません。</dt>
<dd>
<p>カナミックネットワーク介護システムにログインするためにはJavaScriptを有効にする必要があります。</p>
<p class="mb05em">JavaScriptを有効にするには[ツール]→[インターネットオプション]のセキュリティタブ内、下部にある『レベルのカスタマイズ』をクリックし『アクティブスクリプト』項目を『有効にする』に設定してください。</p>
<p><a href="http://www.adobe.com/shockwave/download/index.cgi?Lang=Japanese&amp;P1_Prod_Version=ShockwaveFlash" target="_blank"><img src="../common/img/bn_get-flash-player.gif" alt="Get Flash Player" class="fl mr20" /></a>Adobe FLASH PLAYERが入っていない場合は<a href="http://www.adobe.com/shockwave/download/index.cgi?Lang=Japanese&amp;P1_Prod_Version=ShockwaveFlash" target="_blank" class="externalLink">Adobe FLASH PLAYERのダウンロードサイト</a>より無料でダウンロード出来ますのでダウンロードしてください。</p>
</dd>
</dl>
</div>

<div class="noFlashNoScript pkg">
<dl class="noimage noborder">
<dt>FLASH PLAYERが入れられない場合は各システム名のボタンをクリックしてログイン画面へ移動してください。</dt>
<dd>
<ul>
<li><a href="javascript:loadClassic('https://www2.kanamic.net/kanamic/jsp/default/cic/');" title="新規ウィンドウでCICシステムログイン画面が開きます"><img src="../common/img/btn_cic.gif" alt="CICシステム" class="btn" /></a></li>
<li><a href="javascript:loadClassic('https://www2.kanamic.net/kanamic/jsp/default/ham/');" title="新規ウィンドウでHAMシステムログイン画面が開きます"><img src="../common/img/btn_ham.gif" alt="HAMシステム" class="btn" /></a></li>
<li><a href="javascript:loadClassic('https://www.kanamic.net/portalsite/');" title="新規ウィンドウでTRITRUSシステムログイン画面が開きます"><img src="../common/img/btn_tritrus.gif" alt="TRITRUSシステム" class="btn" /></a></li>
</ul>
</dd>
</dl>
</div>
</div>
<script type = "text/javascript">
var so = new SWFObject("https://www.kanamic.net/flash/check.swf", "flashtest", "1px", "1px", "8.0.0");
so.addParam("wmode", "transparent");
so.write("flashContent2");
</script>-->
<!--// end #primary ====================--></div>

<div id="secondary">
<dl id="localNav">
<dt><img src="../common/img/inquiry/heading_inquiry-main.gif" width="212" height="35" alt="資料請求・お問合せ" /></dt>
<dd>
<ul>
<li id="returnToHome"><a href="https://www.kanamic.net/">ホームに戻る</a></li><!--
--></ul>
</dd>
</dl>
<!--// end #secondary ====================--></div>
<br clear="all"/>
<!--// end #pageBody ====================--></div>
<div id="pagebgBottom" class="png_bg"></div>

<!--// end #containerInner ============--></div>
<!--// end #container =================--></div>





<div id="footer" class="cb">

	<address class="cl">
All Rights Reserved. Copyright KANAMIC NETWORK Co.LTD 2000-
<script type="text/javascript">myDate = new Date();myYear = myDate.getFullYear();document.write(myYear);</script>
</address>
<!--// end #footer ====================--></div></body>
</html>
