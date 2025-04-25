<%@ page language="java" contentType="text/html; charset=UTF-8"
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
<title>資料請求・お問合せフォーム | 株式会社カナミックネットワーク</title>
<link rel="start" href="http://www.kanamic.net/" title="Home" />
<link rel="Shortcut Icon" href="http://www.kanamic.net/favicon.ico" type="image/vnd.microsoft.icon" />
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
<script language="javascript">
<!--  
	<%-- //TODO:20091126 narita 資料請求フォーム改修 個人情報取り扱いイベント --%>
	var clickFlg = true;
	var notAgreeMsg = '個人情報の取り扱いに同意しなければ、進めません。';
	
	function submitWithAgree()
	{
		if(clickFlg)
		{
			if(document.getElementById("<%=Params.AGREE %>1").checked)
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
<li><a href="http://www.kanamic.net/">ホーム</a></li>
<li>資料請求・お問合せ</li>
</ul>




<div class="section mb20">

<p>このページから、IRに関するお問合せをいただきましても、回答いたしかねますのでご了承ください。<br />
<a href="http://www.kanamic.net/ir/toiawa.html">IRに関するお問合せはこちらをご覧ください。</a></p>
<p>資料請求及びお問合せは次の電話番号にお電話いただくか、下記フォームに必要事項を、ご入力の上、一番下の［入力内容確認画面へ］ボタンを押してください。</p>
<table style="width:330px" border="0" cellpadding="0" cellspacing="0" class="companyData">
<tr>
<th scope="col"><p class="fs15 mb0" style="font-weight:bold;">お電話でのお問合せのお客さま</p>
</th>
</tr>
<tr>
<td><p class="mb05em fs16">03-5798-3955</p>
<p class="fs10 mb0">受付時間は平日の9時00分～18時00分<br />
［土曜日、日曜日、および祝祭日、年末年始・GW・夏季休暇時は休業日となります。但し毎月10日（国保請求最終日）直前の土曜日は営業日となっておりますので、通常通り対応を行なっております。］</p></td>
</tr>
</table>
<!-- // end .section =============================-->
</div>

<form action="./confirm.jsp" method="post">
<div class="section">
<h2><img src="../common/img/inquiry/h2_inquiry02.gif" alt="資料請求・お問合せフォーム" width="600" height="38" title="資料請求・お問合せフォーム" /></h2>
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
	<input type="text" name="<%=Params.ADDNUM %>" id="addNum" style="ime-mode: disabled;" maxlength="8"
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
	<input type="text" name="<%=Params.TEL %>" id="tel" style="ime-mode: disabled;" maxlength="13"
	value="<%=getPal(request, Params.TEL) %>" class="wd160" maxlength="13"/></td>
</tr>
<tr>
<th scope="row">FAX番号<br />
<span>記入例：03-5000-5000</span></th>
<td>
<% if (validMap.get(Params.FAX) != null) { %>
	<em><%=validMap.get(Params.FAX) %></em><br />
	<% } %>
	<input type="text" name="<%=Params.FAX %>" id="fax" style="ime-mode: disabled;" maxlength="13"
	value="<%=getPal(request, Params.FAX) %>" class="wd160" maxlength="13"/></td>
</tr>
<tr>
<th scope="row">E-Mail</th>
<td>
<% if (validMap.get(Params.MAIL) != null) { %>
	<em><%=validMap.get(Params.MAIL) %></em><br />
	<% } %>
	<input type="text" name="<%=Params.MAIL %>" id="mail" style="ime-mode: disabled;" maxlength="43"
	value="<%=getPal(request, Params.MAIL) %>" class="wd160" /></td>
</tr>

<%-- //TODO:20091126 narita 資料請求フォーム改修 資料請求コンポーネント追加--%>

<th scope="row">ご希望の資料を<br />
お選びください<span class="redColor">★</span></th>
<td>
<% if (validMap.get(Params.HAM) != null) { %>
	<em><%=validMap.get(Params.HAM) %></em><br />
	<% } %>
<input type="checkbox" name="<%=Params.HAM %>" id="ham"
	value="1" <%=getPal(request, Params.HAM).equals("") ? "" : "checked" %> />
<label for="ham">HAMシステム<br />
(訪問介護/通所介護/福祉用具/GH/訪問看護/訪問入浴/障害者総合支援/通所リハビリ/小規模多機能型生活介護/特定施設[有料老人ホーム]/夜間対応訪問介護/自費サービス)</label>
<br />
<input type="checkbox" name="<%=Params.CIC %>" id="cic"
	value="1" <%=getPal(request, Params.CIC).equals("") ? "" : "checked" %> />
<label for="cic">CICシステム<br />
（居宅介護支援/地域包括支援）</label>
<br /> 
<input type="checkbox" name="<%=Params.TRITRUS %>" id="tritrus"
	value="1" <%=getPal(request, Params.TRITRUS).equals("") ? "" : "checked" %> />
<label for="tritrus">TRITRUSシステム<br />
（ショートステイ/老人福祉施設/老人保健施設）</label>
</td>
</tr>
<tr>

<%-- 
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
 --%>

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
<p>当社が保有しているお客さまの個人情報の開示・訂正・利用停止（以下「開示等」といいます。）を請求される場合に関しては、「個人情報の開示・訂正・利用停止をご請求される場合の手続きについて」(<a href="http://www.kanamic.net/pdf/privacy_demand.pdf">http://www.kanamic.net/pdf/privacy_demand.pdf</a>)のとおりといたします。</p>
<h3>※お客様へのお願い</h3>
<ol>
<li>当社がご提供するサービスのほとんどは、お客さまの個人情報を必要とせずご利用いただけます。ただし、お客さまから個人情報のご提供を受けない場合にご提供できないサービスもありますことを事前にご承知おきください。</li>
<li>当社のホームページからリンクされている当社外のホームページにおけるご本人の個人情報の安全性の確保については、当社では責任を負いかねますので、ご承知おきください。</li>
<li>お客さまは、本取り扱い説明にご同意いただいた上で情報の入力をお願いします。本取り扱い説明にご同意いただけない場合には、当グループが提供するお問い合わせサービスがご利用いただけない場合があります。</li>
</ol>
<dl>
<dt>&lt;当社の個人情報に関する責任者の連絡先&gt;</dt>
<dd>平成17年11月11日制定<br />
平成26年5月1日改正</dd>
<dd>株式会社カナミックネットワーク<br />
個人情報保護管理者　磯　巧</dd>
<dd>
<address>
〒150-6031<br />
東京都渋谷区恵比寿4-20-3 恵比寿ガーデンプレイスタワー31階
</address>
</dd>
<dd>TEL：03-5798-3955</dd>
<dd>FAX：03-5798-3951</dd>
</dl>
</div>
<% //TODO:20091126 narita 資料請求フォーム改修 個人情報取り扱いにかんする必須チェック用メッセージ
	if (validMap.get(Params.AGREE) != null) { %>
	<em><%=validMap.get(Params.AGREE) %></em><br />
	<% } %>
<p style="text-align:center;">
	<input id="<%=Params.AGREE %>1" type="radio" value="1" name="<%=Params.AGREE %>" />
	<label for="<%=Params.AGREE %>1">上記事項に同意する。</label>
	<input id="<%=Params.AGREE %>2" type="radio" value="" name="<%=Params.AGREE %>"/>
	<label for="<%=Params.AGREE %>2">上記事項に同意しない。</label></p>
</p>

</td>
</tr>
</table>
<p class="nextScreen tc">
<img src="../common/img/inquiry/kakunin.gif" width="212" height="38" class="btn" onclick="submitWithAgree();"/><br />
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
<dt><img src="../common/img/inquiry/heading_inquiry-main.gif" width="212" height="35" alt="資料請求・お問合せ" /></dt>
<dd>
<ul>
<li id="returnToHome"><a href="http://www.kanamic.net/">ホームに戻る</a></li><!--
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
<!--// end #footer ====================--></div>
</body>
</html>
