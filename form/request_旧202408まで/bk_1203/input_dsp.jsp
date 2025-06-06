﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.kanamic.website.request.*" %>
<%@ page import="net.kanamic.framework.util.*" %>
<%@ page import="net.kanamic.framework.validator.*" %>
<%@ page import="java.util.*" %>
<%! 
/*** 宣言部 ***/
//JSPの宣言は変換後のサーブレットのメンバとなるため、
//その状態がコンテナで一意に扱われる。JSPの宣言で変数フィールド
//を定義するとセッションにかかわらず一意の状態を維持するので
//JSPの宣言における変数フィールドは注意が必要。

//入力値を取得するローカルメソッド
private String getPal(ServletRequest req, String palName)
{
	return DoText.purgeNull(req.getParameter(palName));
}
//選択文字列を出力するメソッド
private String choiced(String strOut, ServletRequest req, String pal, String val, boolean def)
{
	String rtn = "";
	
	String[] ary = req.getParameterValues(pal);
	if(ary != null)
    {   
        Arrays.sort(ary);//配列のソート
        if(Arrays.binarySearch(ary,val) >= 0)
        {
            rtn = strOut;
        }
        else if(def && ary.length == 0)
        {
        	rtn = strOut;
        }
    }
	else if(def)
	{
		rtn = strOut;
	}
	return rtn;
}
%>

<%
	//Validate用マップオブジェクトのローカル変数
	Map<String, String> validMap = new HashMap<String, String>();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ja" lang="ja" dir="ltr"><!-- InstanceBegin template="/Templates/base.dwt" codeOutsideHTMLIsLocked="false" -->
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
<!-- InstanceBeginEditable name="EditDescription" -->
<meta name="Description" content="カナミックネットワーク介護システムに関するお問合せ、資料請求用フォームのページです。" />
<!-- InstanceEndEditable --><!-- InstanceBeginEditable name="EditKeywords" -->

<!-- InstanceEndEditable -->
<meta name="copyright" content="http://www.kanamic.net" />
<!-- InstanceBeginEditable name="doctitle" -->
<title>資料請求・お問合せフォーム | 株式会社カナミックネットワーク</title>
<!-- InstanceEndEditable -->
<link rel="start" href="http://www.kanamic.net/" title="Home" />
<link rel="Shortcut Icon" href="http://www.kanamic.net/favicon.ico" type="image/vnd.microsoft.icon" />
<link href="../../common/css/import.css" rel="stylesheet" type="text/css" media="screen,tv" />
<link href="../../common/css/print.css" rel="stylesheet" type="text/css" media="print" />
<script type="text/javascript" src="../../common/js/geometry.js"></script>
<script type="text/javascript" src="../../common/js/jquery-1.2.3.pack.js"></script>
<script type="text/javascript" src="../../common/js/jquery-accordion.js"></script>
<script type="text/javascript" src="../../common/js/thickbox-3.1.js"></script>
<script type="text/javascript" src="../../common/js/yuga-0.6.1.js"></script>
<script type="text/javascript" src="../../common/js/swfobject.js"></script>
<script type="text/javascript" src="../../common/js/ll.js"></script>
<script type="text/javascript" src="../../common/js/addLayer.js"></script>
<script type="text/javascript" src="../../common/js/heightLine.js"></script>
<script type="text/javascript" src="../../common/js/jquery.droppy.js"></script>
<script language="javascript">
<!--  
	<%-- //TODO:20091126 narita 資料請求フォーム改修 個人情報取り扱いイベント --%>
	var clickFlg = true;
	var notAgreeMsg = '個人情報の取り扱いに同意しなければ、進めません。';
	
	function submitWithAgree()
	{
		if(clickFlg)
		{
			if(document.getElementById("<%=Params.AGREE %>").checked)
			{
				clickFlg = false;
				document.forms[0].submit();
			}
			else
			{
				alert(notAgreeMsg);
			}
			
			setTimeout(function(){
				clickFlg = true;
			},10000);
		}
	}
//-->
</script>
<!--[if IE 6]>
<script type="text/javascript" src="../../common/js/DD_belatedPNG_0.0.8a-min.js"></script>
<script>DD_belatedPNG.fix('.png_bg,.iepngfix');</script>
<![endif]-->
<!-- InstanceBeginEditable name="head" --><!-- InstanceEndEditable -->
<!-- InstanceParam name="bodyID" type="text" value="inquiry" -->
<!-- InstanceParam name="topiPath_switch" type="number" value="1" -->
<!-- InstanceParam name="return-top" type="boolean" value="true" -->
<!-- InstanceParam name="category_URL" type="URL" value="../../common/img/inquiry/heading_inquiry-main.gif" -->
<!-- InstanceParam name="topiPath_URL" type="URL" value="メイングループURLを入力" -->
<!-- InstanceParam name="topiPath_URL2" type="URL" value="サブグループURLを入力" -->
<!-- InstanceParam name="category_alt" type="text" value="資料請求・お問合せ" -->
<!-- InstanceParam name="update" type="boolean" value="false" -->
<!-- InstanceParam name="update_class" type="text" value="newCaredo" -->
<!-- InstanceParam name="update_URL" type="URL" value="index.html" -->
<!-- InstanceParam name="h1のtitle属性を入力" type="text" value="" -->
</head>

<body id="inquiry">
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-MZL6ZGP"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
<div id="container">
<div id="containerInner">
<div id="header">
<p id="siteID"><a href="http://www.kanamic.net/index.html"><img src="../../common/img/logo_k.gif" alt="カナミックネットワーク" width="182" height="58"/></a></p>
<p id="kLogo2"><img src="../../common/img/logo_k2.gif" alt="カナミックネットワーク" width="220" height="16"/></p>
<p id="sitemapNav"><a href="http://www.kanamic.net/sitemap.html"><img src="../../common/img/nav_sitemap.gif" alt="カナミックネットワーク" width="76" height="12"/></a></p>
<p id="linksNav"><a href="http://www.kanamic.net/links.html"><img src="../../common/img/nav_links.gif" alt="カナミックネットワーク" width="57" height="12"/></a></p>
<!-- #BeginLibraryItem "/Library/text_globalNav.lbi" -->
<ul id="globalNav" class="nav">
<li id="navHome"><a href="http://www.kanamic.net/index.html" title="カナミックネットワークトップページへ">カナミックネットワークホーム</a></li>
<li id="navSystem"><a href="http://www.kanamic.net/system" title="介護ソフト・システムの紹介ページへ">システム紹介</a>
<ul>
<li><a href="http://www.kanamic.net/system/index.html">システムコンセプト</a></li>
<li><a href="http://www.kanamic.net/system/asp.html">ASPとは</a></li>
<li><a href="http://www.kanamic.net/system/lineup.html">介護システムラインアップ</a></li>
<li><a href="http://www.kanamic.net/system/support.html">サポート体制</a></li><li
><a href="http://www.kanamic.net/system/spec.html">介護システム推奨環境</a></li><li
><a href="http://www.kanamic.net/system/price.html">介護システム利用料金</a></li
><li><a href="http://www.kanamic.net/system/recommend.html">推奨の言葉</a></li
><li><a href="http://www.kanamic.net/system/results.html">学会・公的モデル事業・受賞歴</a></li
></ul></li>
<li id="navCompany"><a href="http://www.kanamic.net/company/" title="カナミックネットワーク会社案内のページへ">会社案内</a>
<ul>
<li><a href="http://www.kanamic.net/company/index.html">企業コンセプト</a></li
><li><a href="http://www.kanamic.net/company/outline.html">会社概要</a></li
><li><a href="http://www.kanamic.net/company/access.html">交通・アクセス</a></li
><li><a href="http://www.kanamic.net/company/recruit.html" class="switch0">採用情報</a></li
><li><a href="http://www.kanamic.net/company/privacy.html">プライバシーポリシー</a></li
></ul></li>

<li id="navCaredo"><a href="http://www.kanamic.net/caredo/" title="介護の情報をご紹介するけあ道のページへ">けあ道</a>
<ul>
<li><a href="http://www.kanamic.net/caredo/index.html">けあ道トップ</a></li
><li><a href="http://www.kanamic.net/caredo/r-t_talk/iryo-kaigo_profile.html" class="switch1">座談会</a></li
><li><a href="http://www.kanamic.net/caredo/interview/houkatsu-theme1.html" class="switch0">インタビュー</a></li
><li><a href="http://www.kanamic.net/caredo/k-front/komuro1-1.html">介護事業最前線</a></li
><li><a href="http://www.kanamic.net/caredo/useful/book1.html">お役立ち情報</a></li
><li><a href="http://www.service-quality.jp/recipe/recipe.html" target="_blank" title="新しいウィンドウが開きます">介護食レシピシミュレータ</a></li></ul></li>
<li id="navInquiry"><a href="https://www.kanamic.net/form/request/input.jsp" title="カナミックネットワーク介護ソフト・システムの資料請求・お問合せのページへ" onclick="pageTracker._trackEvent('Gnav', 'Request', 'Form')">資料請求・お問合せ</a></li>
</ul>
<!-- #EndLibraryItem --><!--// end #header ====================-->
</div>
<div id="headingBg">
<div class="titleBg">
<h1 title=""><!-- InstanceBeginEditable name="h1_image" --><img src="../../common/img/inquiry/h1_inquiry.png" alt="資料請求・お問合せ" width="284" height="31" class="png_bg" title="資料請求・お問合せ" /><!-- InstanceEndEditable --></h1></div>
</div>
<div id="pagebgTop" class="png_bg"></div>
<div id="pageBody" class="pkg png_bg">


<div id="primary" class="cl">


<ul id="topicPath" class="pkg">
<li><a href="http://www.kanamic.net/index.html">ホーム</a></li>
<li>資料請求・お問合せ</li>
</ul>




<!-- InstanceBeginEditable name="Edit_main-content" -->
<div class="section mb20">

<p>資料請求及びお問合せは次の電話番号にお電話いただくか、下記フォームに必要事項を、ご入力の上、一番下の［入力内容確認画面へ］ボタンを押してください。</p>
<table style="width:330px" border="0" cellpadding="0" cellspacing="0" class="companyData">
<tr>
<th scope="col"><p class="fs15 mb0" style="font-weight:bold;">お電話でのお問合せのお客さま</p>
</th>
</tr>
<tr>
<td><p class="mb05em fs16">03-5759-1175</p>
<p class="fs10 mb0">受付時間は平日の9時00分～18時00分<br />
［土曜日、日曜日、および祝祭日、年末年始・GW・夏季休暇時は休業日となります。但し毎月10日（国保請求最終日）直前の土曜日は営業日となっておりますので、通常通り対応を行なっております。］</p></td>
</tr>
</table>
<!-- // end .section =============================-->
</div>

<form action="./confirm.jsp" method="post">
<div class="section">
<h2><img src="../../common/img/inquiry/h2_inquiry02.gif" alt="資料請求・お問合せフォーム" width="600" height="38" title="資料請求・お問合せフォーム" /></h2>
<%
if(request.getAttribute("validMap") != null) {
    validMap = (Map<String,String>)request.getAttribute("validMap");
%>
<p class="error">入力ミスがありました</p>
<% }%>
<p><span class="redColor">★</span>印のついている項目は必須項目ですので必ずご記入下さい。<br />
<strong>入力の際、全角英数、半角カタカナはご利用できません</strong></p>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="inquiryTable" summary="カナミックネットワーク資料請求・お問合せフォーム">
<caption>
資料請求・お問合せフォーム
</caption>
<tr>
<th scope="row">ご法人名<span class="redColor">★</span></th>
<td>
<% if (validMap.get(Params.CORPORATENAME) != null) { %>
	<em><%=validMap.get(Params.CORPORATENAME) %></em><br />
	<% } %>
<input type="text" name="<%=Params.CORPORATENAME %>" id="corporateName" class="wd200"
	value="<%=getPal(request, Params.CORPORATENAME) %>" /></td>
</tr>
<tr>
<th scope="row">ご担当者名<span class="redColor">★</span></th>
<td>
<% if (validMap.get(Params.CHARGENAME) != null) { %>
	<em><%=validMap.get(Params.CHARGENAME) %></em><br />
	<% } %>
	<input type="text" name="<%=Params.CHARGENAME %>" id="chargeName" class="wd200"
	value="<%=getPal(request, Params.CHARGENAME) %>" /></td>
</tr>
<tr>
<th scope="row">郵便番号<br />
<span>記入例：141-0031</span></th>
<td>
<% if (validMap.get(Params.ADDNUM) != null) { %>
	<em><%=validMap.get(Params.ADDNUM) %></em><br />
	<% } %>
	<input type="text" name="<%=Params.ADDNUM %>" id="addNum"
	value="<%=getPal(request, Params.ADDNUM) %>" class="wd100" /></td>
</tr>
<tr>
<th scope="row">ご住所<span class="redColor">★</span></th>
<td>
<% if (validMap.get(Params.ADD2) != null) { %>
	<em><%=validMap.get(Params.ADD2) %></em><br />
	<% } %>
<select name="<%=Params.ADD1 %>"  class="mb03em">
<option <%=choiced("selected='selected'",request,Params.ADD1,"北海道", false)%>>北海道</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"青森県", false)%>>青森県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"岩手県", false)%>>岩手県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"宮城県", false)%>>宮城県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"秋田県", false)%>>秋田県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"山形県", false)%>>山形県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"福島県", false)%>>福島県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"茨城県", false)%>>茨城県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"栃木県", false)%>>栃木県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"群馬県", false)%>>群馬県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"埼玉県", false)%>>埼玉県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"千葉県", false)%>>千葉県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"東京都", true)%>>東京都</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"神奈川県", false)%>>神奈川県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"山梨県", false)%>>山梨県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"長野県", false)%>>長野県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"新潟県", false)%>>新潟県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"富山県", false)%>>富山県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"石川県", false)%>>石川県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"福井県", false)%>>福井県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"岐阜県", false)%>>岐阜県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"静岡県", false)%>>静岡県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"愛知県", false)%>>愛知県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"三重県", false)%>>三重県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"滋賀県", false)%>>滋賀県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"京都府", false)%>>京都府</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"大阪府", false)%>>大阪府</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"兵庫県", false)%>>兵庫県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"奈良県", false)%>>奈良県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"和歌山県", false)%>>和歌山県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"鳥取県", false)%>>鳥取県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"島根県", false)%>>島根県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"岡山県", false)%>>岡山県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"広島県", false)%>>広島県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"山口県", false)%>>山口県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"徳島県", false)%>>徳島県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"香川県", false)%>>香川県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"愛媛県", false)%>>愛媛県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"高知県", false)%>>高知県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"福岡県", false)%>>福岡県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"佐賀県", false)%>>佐賀県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"長崎県", false)%>>長崎県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"熊本県", false)%>>熊本県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"大分県", false)%>>大分県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"宮崎県", false)%>>宮崎県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"鹿児島県", false)%>>鹿児島県</option>
<option <%=choiced("selected='selected'",request,Params.ADD1,"沖縄県", false)%>>沖縄県</option>
</select><br />
<input type="text" name="<%=Params.ADD2 %>" id="add2"
	value="<%=getPal(request, Params.ADD2) %>" class="wd350" /></td>
</tr>
<tr>
<th scope="row">電話番号<span class="redColor">★</span><br />
<span>記入例：03-5000-5000</span></th>
<td>
<% if (validMap.get(Params.TEL) != null) { %>
	<em><%=validMap.get(Params.TEL) %></em><br />
	<% } %>
	<input type="text" name="<%=Params.TEL %>" id="tel"
	value="<%=getPal(request, Params.TEL) %>" class="wd160" maxlength="13"/></td>
</tr>
<tr>
<th scope="row">FAX番号<br />
<span>記入例：03-5000-5000</span></th>
<td>
<% if (validMap.get(Params.FAX) != null) { %>
	<em><%=validMap.get(Params.FAX) %></em><br />
	<% } %>
	<input type="text" name="<%=Params.FAX %>" id="fax"
	value="<%=getPal(request, Params.FAX) %>" class="wd160" maxlength="13"/></td>
</tr>
<tr>
<th scope="row">E-Mail</th>
<td>
<% if (validMap.get(Params.MAIL) != null) { %>
	<em><%=validMap.get(Params.MAIL) %></em><br />
	<% } %>
	<input type="text" name="<%=Params.MAIL %>" id="mail"
	value="<%=getPal(request, Params.MAIL) %>" class="wd160" /></td>
</tr>

<%-- TODO:20091126 narita 資料請求フォーム改修 資料請求コンポーネント追加--%>
<tr>
<th scope="row">資料請求</th>
<td><label for="siryou_1">
<input id="siryou_1" type="radio" value="資料請求" name="<%=Params.SIRYOU %>" <%=choiced("checked='checked'",request,Params.SIRYOU,"資料請求", true)%> />
資料請求
</label>
<label for="siryou_2">
<input id="siryou_2" type="radio" value="不要" name="<%=Params.SIRYOU %>" <%=choiced("checked='checked'",request,Params.SIRYOU,"不要", false)%> />
不要
</label></td>
</tr>
<tr>
<th scope="row">お問合せ内容など<br />
ご記入ください</th>
<td><textarea name="<%=Params.INQUIRY %>" id="inquiry"
	cols="45" rows="5"><%=getPal(request, Params.INQUIRY) %></textarea></td>
</tr>
<tr>
<th scope="row"><p>個人情報の取り扱いについて<span class="redColor">★</span></p>
<p class="fs10">(必ずお読みください)</p></th>
<td valign="top"><p>資料請求・お問合せいただくには下記｢個人情報保護に関して｣をお読みいただき、記載されている内容に関してご同意いただく必要があります。</p>
<p class="fs10">弊社「個人情報保護方針」については<a href="http://www.kanamic.net/company/privacy.html" target="_blank">こちら</a>をご覧ください。</p>
<div class="inquiryCheck mb10">
<h2>「個人情報保護に関して」（抜粋）</h2>
<h3>&lt;個人情報の利用目的について&gt;</h3>
<p>当社のサイトにて収集する個人情報は、次のような目的に使用されます。</p>
<ul>
<li>各種お問合せへの回答及び資料送付 </li>
<li>ご購入商品または当社取り扱い商品の新情報の提供</li>
<li>個人情報を特定しない統計情報への利用</li>
</ul>
<p>上記目的の範囲外で利用する場合は事前にお客様にお知らせし、ご了解をいただいた場合に限り利用させていただきます。</p>
<h3>&lt;個人情報の第三者への開示について&gt;</h3>
<p>当社は、原則として、ご提供いただいた個人情報を第三者に提供・開示することはいたしません。<br />
ただし、当社と機密保持契約を締結している協力企業、提携会社及び業務委託会社に対して個人情報を開示する場合があります。<br />
その場合においても、当社が提供するサービスと同様、個人情報に関する諸規程を遵守し、その管理を行い当社との間において個人情報を遵守する契約条項を義務づけます。<br />
また、お客様本人より個人情報の開示を求められた場合は、合理的な期間内において可能範囲内の情報を通知することができます。<br />
上記以外において、以下のような場合、個人の情報を開示いたします。<br />
当社が従うべき法律に基づき個人情報の開示を要求された場合（裁判所、検察庁、警察などの法的機関からの法律に基づく正式な照会を受けた場合）、当社は、これに応じて情報を開示する場合があります。</p>
<h3>&lt;SSLについて&gt;</h3>
<p>弊社のウェブサイトは、お客様の個人情報を保護するために「SSL」に対応しているコンテンツ が一部あります。<br />
Netscape　Navigator、Microsoft  Internet　Explorerといったセキュリティ機能に対応したブラウザを使用することで、お客様が入力される名前や住所あるいは電話番号などの  個人情報が自動的に暗号化されて送受信されるため、万が一、送信データが第三者に傍受された場合でも、内容が盗み取られる心配はありません。<br />
SSLに対応していないブラウザをご利用の場合は、弊社のウェブサイトにアクセスできなかったり、情報の入力ができない場合があります。</p>
<h3>&lt;個人情報の開示・訂正・利用停止の請求手続きの流れに関して&gt;</h3>
<p>当社が保有しているお客さまの個人情報の開示・訂正・利用停止（以下「開示等」といいます。）を請求される場合に関しては、「個人情報の開示・訂正・利用停止を求められた場合の手続きの流れ」(<a href="http://www.kanamic.net/company/privacy2.html">http://www.kanamic.net/company/privacy2.html</a>)のとおりといたします。</p>
<h3>※お客様へのお願い</h3>
<ol>
<li>当社がご提供するサービスのほとんどは、お客さまの個人情報を必要とせずご利用いただけます。ただし、お客さまから個人情報のご提供を受けない場合にご提供できないサービスもありますことを事前にご承知おきください。</li>
<li>当社のホームページからリンクされている当社外のホームページにおけるご本人の個人情報の安全性の確保については、当社では責任を負いかねますので、ご承知おきください。</li>
<li>お客さまは、本取り扱い説明にご同意いただいた上で情報の入力をお願いします。本取り扱い説明にご同意いただけない場合には、当グループが提供するお問い合わせサービスがご利用いただけない場合があります。</li>
</ol>
<dl>
<dt>&lt;当社の個人情報に関する責任者の連絡先&gt;</dt>
<dd>平成17年4月1日制定<br />
平成20年6月2日改正</dd>
<dd>株式会社カナミックネットワーク<br />
個人情報保護管理者　山本　拓真</dd>
<dd>
<address>
〒141-0031<br />
東京都品川区西五反田8-1-14　最勝ビル8F
</address>
</dd>
<dd>TEL：03-5759-1175</dd>
<dd>FAX：03-5759-1185</dd>
</dl>
</div>
<p class="redColor" style="font-weight:bold; text-align:center;">
<% //TODO:20091126 narita 資料請求フォーム改修 個人情報取り扱いにかんする必須チェック用メッセージ
	if (validMap.get(Params.AGREE) != null) { %>
	<em><%=validMap.get(Params.AGREE) %></em><br />
	<% } %>
<input id="<%=Params.AGREE %>" type="checkbox" value="1" name="<%=Params.AGREE %>"/>
<label for="">上記事項に同意する。</label></p></td>
</tr>
</table>
<p class="nextScreen tc">
<img src="../../common/img/inquiry/kakunin.gif" width="212" height="38" class="btn" onclick="submitWithAgree();"/><br />
<%-- <input type="submit" name="<%=Params.NEXT %>" id="next" value="同意して確認画面に進む" />  --%>
</p>
<!-- // end .section =============================--></div>
</form>
<script language="javascript" type="text/javascript">
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
<script language="JavaScript" src="https://www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<img height="1" width="1" src="https://www.googleadservices.com/pagead/conversion/1070139595/?value=1.0&label=Lead&script=0" />
</noscript>
<!-- InstanceEndEditable -->


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
var so = new SWFObject("http://www.kanamic.net/flash/check.swf", "flashtest", "1px", "1px", "8.0.0");
so.addParam("wmode", "transparent");
so.write("flashContent2");
</script>-->
<!--// end #primary ====================--></div>

<div id="secondary">
<dl id="localNav">
<dt><img src="../../common/img/inquiry/heading_inquiry-main.gif" width="212" height="35" alt="資料請求・お問合せ" /></dt>
<dd>
<!-- InstanceBeginEditable name="Edit_local-navigation" -->
<ul>
<li id="returnToHome"><a href="http://www.kanamic.net/index.html">ホームに戻る</a></li><!--
--></ul>
<!-- InstanceEndEditable --></dd>
</dl>
<!--// end #secondary ====================--></div>
<br clear="all"/>
<!--// end #pageBody ====================--></div>
<div id="pagebgBottom" class="png_bg"></div>

<!--// end #containerInner ============--></div>
<!--// end #container =================--></div>

<!-- #BeginLibraryItem "/Library/footer.lbi" -->




<div id="footer" class="cb">
<ul>
<li><a href="http://www.kanamic.net/index.html">ホーム</a></li>
<li><a href="http://www.kanamic.net/system/index.html">システム紹介</a></li>
<li><a href="http://www.kanamic.net/company/index.html">会社案内</a></li>
<li><a href="http://www.kanamic.net/company/privacy.html">プライバシーポリシー</a></li>
<li><a href="http://www.kanamic.net/caredo/index.html">けあ道</a></li>
<li><a href="https://www.kanamic.net/form/request/input.jsp" onclick="pageTracker._trackEvent('Footer', 'Request', 'Form')">資料請求・お問合せ</a></li>
<li><a href="http://www.kanamic.net/links.html">リンク集</a></li>
<li><a href="http://www.kanamic.net/sitemap.html">サイトマップ</a></li>
</ul>

	<address class="cl">
All Rights Reserved. Copyright KANAMIC NETWORK Co.LTD 2000-
<script type="text/javascript">myDate = new Date();myYear = myDate.getFullYear();document.write(myYear);</script>
</address>
<!--// end #footer ====================--></div><!-- #EndLibraryItem --><script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
var pageTracker = _gat._getTracker("UA-462660-7");
pageTracker._initData();
pageTracker._trackPageview();
</script>
</body>
<!-- InstanceEnd --></html>
