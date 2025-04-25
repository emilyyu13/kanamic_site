<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.kanamic.website.request3.*" %>
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
<d%
  //Validate用マップオブジェクトのローカル変数
  Map<String, String> validMap = new HashMap<String, String>();
%>

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
<meta name="Description" content="カナミックネットワーク介護システムに関するお問合せ、資料請求用フォームのページです。" />
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<meta name="copyright" content="http://www.kanamic.net" />
<title>資料請求・お問合せフォーム | 株式会社カナミックネットワーク</title>
<link rel="start" href="http://www.kanamic.net/" title="Home" />
<link rel="Shortcut Icon" href="http://www.kanamic.net/favicon.ico" type="image/vnd.microsoft.icon" />
<link href="./reset.css" rel="stylesheet" type="text/css" />
<link href="./form_nomenu.css" rel="stylesheet" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="./js/jquery.validate.min.js"></script>
<!-- 郵便番号→住所ライブラリ -->
<script src="https://ajaxzip3.github.io/ajaxzip3.js" charset="UTF-8"></script>
<!-- フォームの半角?全角変換、ハイフン削除 -->
<script type="text/javascript">
$(function(){
    $(".js-characters-change").each(function(i,elm){$(elm).blur(function(){
        charactersChange($(this));
    });
    });
    charactersChange = function(ele){
        var val = ele.val();
        var han = val.replace(/[Ａ-Ｚａ-ｚ０-９]/g,function(s){return String.fromCharCode(s.charCodeAt(0)-0xFEE0)});
    //ハイフン削除
    var han2 = han.replace(/[━‐―－\?ー\-]/g,'');

            $(ele).val(han2);
    }
});
</script>
<!-- フォームのバリデーション -->
<script type="text/javascript">
(function(){
//標準エラーメッセージの変更
  $.extend($.validator.messages, {
    email: '正しいメールアドレスの形式で入力して下さい',
    required: '入力必須です',
    phone: "正しい電話番号の形式で入力してください"
  });
//追加ルールの定義
  var methods = {
    phone: function(value, element){
      return this.optional(element) || /^\d{11}$|^\d{10}$|^\d{3}-\d{4}-\d{4}$/.test(value);
    }
  };
//メソッドの追加
  $.each(methods, function(key) {
    $.validator.addMethod(key, this);
  });
//入力項目の検証ルール"rules"定義
  var rules = {
	  //DLフォーム
		corporateNameReqDL: {required: true},
		yourNameReqDL: {required: true},
		emailReqDL: {required: true, email: true},
	    cityReqDL: {required: true},
		phoneNumberReqDL: {
			required:true,
			phone:true
		},
		agreeChkReqDL: {required:true},
	  //郵送フォーム
		corporateNameReqPost: {required: true},
		yourNameReqPost: {required: true},
		/*email: {required: true, email: true},*/
		phoneNumberReqPost: {
			required:true,
			phone:true
		},
		postalCodeReqPost: {required:true},
		addr11ReqPost: {required: true,},
		agreeChkReqPost: {required:true},
		postalCodeReqPost: {
			required: true,
			minlength: 7,
			maxlength: 7
		},
	  //その他フォーム
		corporateNameReqOther: {required: true},
		yourNameReqOther: {required: true},
		emailReqOther: {required: true, email: true},
	    cityReqOther: {required: true},
		phoneNumberReqOther: {
			required:true,
			phone:true
		},
		contentReqOther: {required:true},
		agreeChkReqOther: {required:true},
		postalCodeReqOther: {
			required: true,
			minlength: 7,
			maxlength: 7
		}
  };
//入力項目ごとのエラーメッセージ定義
  var messages = {
	//エラーメッセージforDLフォーム
	corporateNameReqDL: {required: "法人名をご入力ください"},
    yourNameReqDL: {required: "ご担当者名をご入力ください"},
	emailReqDL: {required: "メールアドレスをご入力ください"},
	cityReqDL: {required: "都道府県を選んでください"},
    phoneNumberReqDL: {required: "電話番号をご入力ください"},
	agreeChkReqDL: {required: "個人情報の取り扱いに同意していただければ先に進めます"},
	//エラーメッセージfor郵送フォーム
	corporateNameReqPost: {required: "法人名をご入力ください"},
    yourNameReqPost: {required: "ご担当者名をご入力ください"},
    phoneNumberReqPost: {required: "電話番号をご入力ください"},
	postalCodeReqPost: {required: "郵便番号をご入力ください"},
    addr11ReqPost: {required: "住所をご入力ください"},
	agreeChkReqPost: {required: "個人情報の取り扱いに同意していただければ先に進めます"},
	postalCodeReqPost: {
	  required: "郵便番号をご入力ください",
	  maxlength: "正しい郵便番号をご入力ください",
		minlength: "正しい郵便番号をご入力ください"
	},
	//エラーメッセージforその他フォーム
	corporateNameReqOther: {required: "法人名をご入力ください"},
    yourNameReqOther: {required: "ご担当者名をご入力ください"},
	emailReqOther: {required: "メールアドレスをご入力ください"},
	cityReqOther: {required: "都道府県を選んでください"},
    phoneNumberReqOther: {required: "電話番号をご入力ください"},
	contentReqOther: {required: "お問い合わせ内容をご入力ください"},
	agreeChkReqOther: {required: "個人情報の取り扱いに同意していただければ先に進めます"},
	postalCodeReqOther: {
	  required: "郵便番号をご入力ください",
	  maxlength: "正しい郵便番号をご入力ください",
		minlength: "正しい郵便番号をご入力ください"
	}
  };
//バリデート処理forDLフォーム
  $(function(){
    $('.mailFormWrapperReqDL').validate({
		onfocusout: false,
		rules: rules,
		messages: messages,
		errorClass: "authError",
		errorElement: "span",
		highlight: function(element, errorClass) {
			  $(element).addClass("formError");
		  },
		unhighlight: function(element, validClass) {
			  $(element).addClass("formValid");
		  },
      //エラーメッセージ出力箇所調整
      errorPlacement: function(error, element) {
		  element.before( error );
	  }
    });
  });
//バリデート処理for郵送フォーム
  $(function(){
    $('.mailFormWrapperReqPost').validate({
		onfocusout: false,
		rules: rules,
		messages: messages,
		errorClass: "authError",
		errorElement: "span",
		highlight: function(element, errorClass) {
			  $(element).addClass("formError");
		  },
		unhighlight: function(element, validClass) {
			  $(element).addClass("formValid");
		  },
      //エラーメッセージ出力箇所調整
      errorPlacement: function(error, element) {
		  element.before( error );
	  }
    });
  });
//バリデート処理forその他フォーム
  $(function(){
    $('.mailFormWrapperReqOther').validate({
		onfocusout: false,
		rules: rules,
		messages: messages,
		errorClass: "authError",
		errorElement: "span",
		highlight: function(element, errorClass) {
			  $(element).addClass("formError");
		  },
		unhighlight: function(element, validClass) {
			  $(element).addClass("formValid");
		  },
      //エラーメッセージ出力箇所調整
      errorPlacement: function(error, element) {
		  element.before( error );
	  }
    });
  });
})();
</script>
<!--フォーム選択切り替えスクリプト-->
<script type="text/javascript">
$(function() {
  $('input[name="mailReq"]#reqDL').click(function() {
    //切り替え
      $('.formMailIn').fadeOut();
      $('.formOther').fadeOut();
      $('.formDL').fadeIn(
		  function() {
			      //スクロール
			  var i = $("#reqDL").index(this)
			  var p = $(".formDL").eq(i).offset().top;
			  $('html,body').animate({ scrollTop: p }, 'fast');
			  
		  });
	  var kbnVal = $(this).val();
	  $('.mailReqKbn').each(function(index, el) {
		  $(el).val(kbnVal);
	  });
  });
  $('input[name="mailReq"]#reqPost').click(function() {
    //切り替え
      $('.formOther').fadeOut();
      $('.formDL').fadeOut();
      $('.formMailIn').fadeIn(
		  function() {
			  //スクロール
			  var i = $("#reqPost").index(this)
			  var p = $(".formMailIn").eq(i).offset().top;
			  $('html,body').animate({ scrollTop: p }, 'fast');
			  
		  });
	  var kbnVal = $(this).val();
	  $('.mailReqKbn').each(function(index, el) {
		  $(el).val(kbnVal);
	  });
  });
  $('input[name="mailReq"]#reqOther').click(function() {
    //切り替え
      $('.formMailIn').fadeOut();
      $('.formDL').fadeOut();
      $('.formOther').fadeIn(
		  function() {
			  //スクロール
			  var i = $("#reqOther").index(this)
			  var p = $(".formOther").eq(i).offset().top;
			  $('html,body').animate({ scrollTop: p }, 'fast');
		  });
      var kbnVal = $(this).val();
      $('.mailReqKbn').each(function(index, el) {
        $(el).val(kbnVal);
      });
  });

  if ( "<%=getPal(request, Params.MAIL_REC_KBN) %>" == "<%=Params.MAIL_REC.POST %>" ){
    //切り替え
      $('.formDL').hide();
      $('.formOther').hide();
      $('.formMailIn').show();
  } else if ( "<%=getPal(request, Params.MAIL_REC_KBN) %>" == "<%=Params.MAIL_REC.DL %>" ){
    //切り替え
      $('.formMailIn').hide();
      $('.formOther').hide();
      $('.formDL').show();
  } else if ( "<%=getPal(request, Params.MAIL_REC_KBN) %>" == "<%=Params.MAIL_REC.OTHER %>" ){
      $('.formMailIn').hide();
      $('.formDL').hide();
      $('.formOther').show();
  }
});
</script>
<!--スマホ時のみ電話番号タップでCallする-->
<script type="text/javascript">
if (navigator.userAgent.match(/(iPhone|iPad|iPod|Android)/)) {
  $(function() {
    $('.callNumber').each(function() {
      var str = $(this).html();
      if ($(this).children().is('img')) {
        $(this).html($('<a>').attr('href', 'tel:' + $(this).children().attr('alt').replace(/-/g, '')).append(str + '</a>'));
      } else {
        $(this).html($('<a>').attr('href', 'tel:' + $(this).text().replace(/-/g, '')).append(str + '</a>'));
      }
    });
  });
}
</script>
</head>

<body>
  <!-- Google Tag Manager (noscript) -->
  <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-MZL6ZGP"
  height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
  <!-- End Google Tag Manager (noscript) -->

  <header>
    <div><img src="img/logo.png" alt="KANAMIC NETWORK"/></div>
  </header>

<div id="thanks">
 <h1>資料請求・お問合せ</h1>
 <p>弊社にご関心をお持ちくださいまして誠にありがとうございます。</p>
</div>
<div id="wrapper">
 <div id="contact">
  <div id="mailReq">
   <h2>Webからのお問合せ</h2>
   <ul>
    <li>
     <input type="radio" name="mailReq" value="<%=Params.MAIL_REC.POST %>" id="reqPost" <%=(getPal(request, Params.MAIL_REC_KBN).equals(Params.MAIL_REC.POST) || getPal(request, Params.MAIL_REC_KBN).equals("")) ? "checked='checked'" : "" %> />
     <label for="reqPost" class="radioBtn">資料請求（郵送）</label>
    </li>
    <li>
     <input type="radio" name="mailReq" value="<%=Params.MAIL_REC.DL %>" id="reqDL" <%=getPal(request, Params.MAIL_REC_KBN).equals(Params.MAIL_REC.DL) ? "checked='checked'" : "" %> />
     <label for="reqDL" class="radioBtn">資料請求（データダウンロード）</label>
    </li>
    <li>
     <input type="radio" name="mailReq" value="<%=Params.MAIL_REC.OTHER %>" id="reqOther" <%=getPal(request, Params.MAIL_REC_KBN).equals(Params.MAIL_REC.OTHER) ? "checked='checked'" : "" %> />
     <label for="reqOther" class="radioBtn">その他のお問合わせ</label>
    </li>
   </ul>
  </div>
  <div id="phoneReq">
   <h2>お電話でのお問合せ</h2>
   <p class="callNumber">03-5798-3955</p>
   <p class="timeIn">受付時間：平日9時00分～18時00分</p>
   <p class="guide">土日祝祭日、年末年始、GW、夏季休暇時は休業となります。<br />
    毎月10日（国保請求最終日）直前の土曜日は通常通り対応を行なっております。</p>
  </div>
  <!-- /#phoneReq --> 

 <!-- /#contact 
 <div id="irReq">
  <h2>IRのお問合せに関するご注意</h2>
  <p>IRに関するお問合せはお電話でのみ承っております。<br />
   メールフォームからのお問合せには回答いたしかねます。</p>
 </div>-->

<!-- /#wrapper -->

<%
if(request.getAttribute("validMap") != null) {
    validMap = (Map<String,String>)request.getAttribute("validMap");
%>
<!--p class="error">入力ミスがありました</p-->
<% }%>

<!-- フォーム(資料請求郵送) -->
<form class="mailFormWrapperReqPost formMailIn" name="reqPost"  action="./confirm_post.jsp" method="post">
 <div id="bredcrumbSec">
  <ul class="pkg" id="breadcrumb">
   <li class="now"><span class="itemNum">1</span>項目の入力</li>
   <li><span class="itemNum">2</span>入力内容の確認</li>
   <li><span class="itemNum">3</span>送信完了</li>
  </ul>
  <p>必要事項を入力し、「入力内容を確認する」ボタンを押してください。</p>
 </div>
 <div class="mailForm">
  <div class="formBox pkg corporateName">
   <div class="formLabel pkg">
    <label for="corporateName">法人名</label>
    <span class="required">必須</span> </div>
   <div class="formContent">
    <% if (validMap.get(Params.POST.CORPORATENAME) != null) { %>
    <em><%=validMap.get(Params.POST.CORPORATENAME) %></em><br />
    <% } %>
    <input type="text" name="<%=Params.POST.CORPORATENAME %>" id="corporateName" placeholder="例）株式会社カナミックネットワーク"  value="<%=getPal(request, Params.POST.CORPORATENAME) %>" />
   </div>
  </div>
  <div class="formBox pkg yourName">
   <div class="formLabel">
    <label for="yourName">ご担当者名</label>
    <span class="required">必須</span> </div>
   <div class="formContent">
    <% if (validMap.get(Params.POST.CHARGENAME) != null) { %>
    <em><%=validMap.get(Params.POST.CHARGENAME) %></em><br />
    <% } %>
    <input type="text" name="<%=Params.POST.CHARGENAME %>" id="yourName" placeholder="例）佐藤　花子"  value="<%=getPal(request, Params.POST.CHARGENAME) %>" />
   </div>
  </div>
  <div class="formBox pkg mailAddress">
   <div class="formLabel">
    <label for="mailAddress">メールアドレス</label>
   </div>
   <div class="formContent">
    <input type="text" name="<%=Params.POST.MAIL %>" id="mailAddress" placeholder="例）hanako@kanamic.net"  value="<%=getPal(request, Params.POST.MAIL) %>" />
   </div>
  </div>
  <div class="formBox pkg phoneNumber">
   <div class="formLabel">
    <label for="phoneNumber">電話番号</label>
    <span class="required">必須</span> </div>
   <div class="formContent">
    <% if (validMap.get(Params.POST.TEL) != null) { %>
    <em><%=validMap.get(Params.POST.TEL) %></em><br />
    <% } %>
    <input type="text" name="<%=Params.POST.TEL %>" id="phoneNumber" placeholder="例）0357983955" class="js-characters-change"  value="<%=getPal(request, Params.POST.TEL) %>" />
   </div>
  </div>
  <div class="formBox pkg postalCode">
   <div class="formLabel">
    <label for="postalCode">郵便番号</label>
    <span class="required">必須</span> </div>
   <div class="formContent pkg">
    <% if (validMap.get(Params.POST.ADDNUM) != null) { %>
    <em><%=validMap.get(Params.POST.ADDNUM) %></em><br />
    <% } %>
    <input type="text" name="<%=Params.POST.ADDNUM %>" id="postalCode" placeholder="例）1506031" class="js-characters-change"  value="<%=getPal(request, Params.POST.ADDNUM) %>" />
    <div class="postal2address-container" onClick="AjaxZip3.zip2addr('postalCodeReqPost','','addr11ReqPost','addr11ReqPost');">
     <button type="button" class="postal2address-button">郵便番号から住所を検索</button>
    </div>
   </div>
  </div>
  <div class="formBox pkg address">
   <div class="formLabel">
    <label for="postalCodeReqPost">住所</label>
    <span class="required">必須</span> </div>
   <div class="formContent">
    <% if (validMap.get(Params.POST.ADD1) != null) { %>
    <em><%=validMap.get(Params.POST.ADD1) %></em><br />
    <% } %>
    <input type="text" name="<%=Params.POST.ADD1 %>" id="address" placeholder="例）東京都渋谷区恵比寿4-20-3　恵比寿ガーデンプレイスタワー31階"  value="<%=getPal(request, Params.POST.ADD1) %>" />
   </div>
  </div>
  <div class="formBox pkg formSubject">
   <div class="formLabel pkg">
    <label for="formSubject">お問い合せ内容</label>
    <div class="irNotice">IRに関するお問合せはお電話でのみ承っております。<br />
     メールフォームからのお問合せには回答いたしかねます。</div>
   </div>
   <div class="formContent">
    <textarea id="formSubject" name="<%=Params.POST.INQUIRY %>"><%=getPal(request, Params.POST.INQUIRY) %></textarea>
   </div>
  </div>
 </div>
 <div class="agreement">
  <div class="policy">
	  <p><a href="../../company/request_privacy.html#sec01" target="_blank">個人情報の取り扱いについて</a><br>（必ず事前にご確認ください）</p>
  </div>
  <p class="agreeChk">
   <input type="checkbox" name="agreeChkReqPost" value="個人情報の取り扱いに同意します。" id="agreeChkReqPost" />
   <label for="agreeChkReqPost" class="chkBoxReqPost">個人情報の取り扱いに同意します。</label>
  </p>
  <div class="submit-container">
   <button type="submit" class="submit-button">入力内容を確認する</button>
  </div>
 </div>
 <input type="hidden" class="mailReqKbn" name="<%=Params.MAIL_REC_KBN %>"
  value="<%=DoText.purgeNull(request.getParameter(Params.MAIL_REC_KBN)) %>" />
</form>
<!-- /フォーム(資料請求郵送) --> 

<!-- フォーム(資料請求DL) -->
<form class="mailFormWrapperReqDL formDL" name="reqDL" action="./confirm_dl.jsp" method="post">
 <div id="bredcrumbSec">
  <ul class="pkg" id="breadcrumb">
   <li class="now"><span class="itemNum">1</span>項目の入力</li>
   <li><span class="itemNum">2</span>入力内容の確認</li>
   <li><span class="itemNum">3</span>送信完了</li>
  </ul>
  <p>必要事項を入力し、「入力内容を確認する」ボタンを押してください。</p>
 </div>
 <div class="mailForm">
  <div class="formBox pkg corporateName">
   <div class="formLabel">
    <label for="corporateName">法人名</label>
    <span class="required">必須</span> </div>
   <div class="formContent">
    <% if (validMap.get(Params.DL.CORPORATENAME) != null) { %>
    <em><%=validMap.get(Params.DL.CORPORATENAME) %></em><br />
    <% } %>
    <input type="text" name="<%=Params.DL.CORPORATENAME %>" id="corporateNameReqDL" placeholder="例）株式会社カナミックネットワーク"  value="<%=getPal(request, Params.DL.CORPORATENAME) %>" />
   </div>
  </div>
  <div class="formBox pkg yourName">
   <div class="formLabel">
    <label for="yourName">ご担当者名</label>
    <span class="required">必須</span> </div>
   <div class="formContent">
    <% if (validMap.get(Params.DL.CHARGENAME) != null) { %>
    <em><%=validMap.get(Params.DL.CHARGENAME) %></em><br />
    <% } %>
    <input type="text" name="<%=Params.DL.CHARGENAME %>" id="yourNameReqDL" placeholder="例）佐藤　花子"  value="<%=getPal(request, Params.DL.CHARGENAME) %>" />
   </div>
  </div>
  <div class="formBox pkg mailAddress">
   <div class="formLabel">
    <label for="mailAddress">メールアドレス</label>
    <span class="required">必須</span> </div>
   <div class="formContent">
    <% if (validMap.get(Params.DL.MAIL) != null) { %>
    <em><%=validMap.get(Params.DL.MAIL) %></em><br />
    <% } %>
    <input type="text" name="<%=Params.DL.MAIL %>" id="mailAddressReqDL" placeholder="例）hanako@kanamic.net"  value="<%=getPal(request, Params.DL.MAIL) %>" />
   </div>
  </div>
  <div class="formBox pkg city">
   <div class="formLabel">
    <label for="city">都道府県</label>
    <span class="required">必須</span> </div>
    <div class="formContent">
	<select name="<%=Params.DL.CITY %>">
	<option value="">未選択</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"北海道", false)%>>北海道</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"青森県", false)%>>青森県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"岩手県", false)%>>岩手県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"宮城県", false)%>>宮城県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"秋田県", false)%>>秋田県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"山形県", false)%>>山形県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"福島県", false)%>>福島県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"茨城県", false)%>>茨城県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"栃木県", false)%>>栃木県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"群馬県", false)%>>群馬県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"埼玉県", false)%>>埼玉県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"千葉県", false)%>>千葉県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"東京都", false)%>>東京都</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"神奈川県", false)%>>神奈川県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"山梨県", false)%>>山梨県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"長野県", false)%>>長野県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"新潟県", false)%>>新潟県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"富山県", false)%>>富山県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"石川県", false)%>>石川県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"福井県", false)%>>福井県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"岐阜県", false)%>>岐阜県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"静岡県", false)%>>静岡県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"愛知県", false)%>>愛知県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"三重県", false)%>>三重県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"滋賀県", false)%>>滋賀県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"京都府", false)%>>京都府</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"大阪府", false)%>>大阪府</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"兵庫県", false)%>>兵庫県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"奈良県", false)%>>奈良県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"和歌山県", false)%>>和歌山県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"鳥取県", false)%>>鳥取県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"島根県", false)%>>島根県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"岡山県", false)%>>岡山県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"広島県", false)%>>広島県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"山口県", false)%>>山口県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"徳島県", false)%>>徳島県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"香川県", false)%>>香川県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"愛媛県", false)%>>愛媛県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"高知県", false)%>>高知県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"福岡県", false)%>>福岡県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"佐賀県", false)%>>佐賀県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"長崎県", false)%>>長崎県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"熊本県", false)%>>熊本県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"大分県", false)%>>大分県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"宮崎県", false)%>>宮崎県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"鹿児島県", false)%>>鹿児島県</option>
	<option <%=choiced("selected='selected'",request,Params.DL.CITY,"沖縄県", false)%>>沖縄県</option>
	</select>
   </div>
  </div>
  <div class="formBox pkg phoneNumber">
   <div class="formLabel">
    <label for="phoneNumber">電話番号</label>
    <span class="required">必須</span> </div>
   <div class="formContent">
    <% if (validMap.get(Params.DL.TEL) != null) { %>
    <em><%=validMap.get(Params.DL.TEL) %></em><br />
    <% } %>
    <input type="text" name="<%=Params.DL.TEL %>" id="phoneNumberReqDL" placeholder="例）0357983955" class="js-characters-change"  value="<%=getPal(request, Params.DL.TEL) %>" />
   </div>
  </div>
  <div class="formBox pkg formSubject">
   <div class="formLabel pkg">
    <label for="formSubject">お問い合せ内容</label>
    <div class="irNotice">IRに関するお問合せはお電話でのみ承っております。<br />
     メールフォームからのお問合せには回答いたしかねます。</div>
   </div>
   <div class="formContent">
    <textarea id="formSubject" name="<%=Params.DL.INQUIRY %>"><%=getPal(request, Params.DL.INQUIRY) %></textarea>
   </div>
  </div>
 </div>
 <div class="agreement">
  <div class="policy">
	  <p><a href="../../company/request_privacy.html#sec01" target="_blank">個人情報の取り扱いについて</a><br>（必ず事前にご確認ください）</p>
  </div>
  <p class="agreeChk">
   <input type="checkbox" name="agreeChkReqDL" value="個人情報の取り扱いに同意します。" id="agreeChkReqDL" />
   <label for="agreeChkReqDL" class="chkBoxReqDL">個人情報の取り扱いに同意します。</label>
  </p>
  <div class="submit-container">
   <button type="submit" class="submit-button">入力内容を確認する</button>
  </div>
 </div>
 <input type="hidden" class="mailReqKbn" name="<%=Params.MAIL_REC_KBN %>"
  value="<%=DoText.purgeNull(request.getParameter(Params.MAIL_REC_KBN)) %>" />
</form>
<!-- /フォーム(資料請求DL) --> 

<!-- フォーム(その他) -->
<form class="mailFormWrapperReqOther formOther" name="reqOther"  action="./confirm_other.jsp" method="post">
 <div id="bredcrumbSec">
  <ul class="pkg" id="breadcrumb">
   <li class="now"><span class="itemNum">1</span>項目の入力</li>
   <li><span class="itemNum">2</span>入力内容の確認</li>
   <li><span class="itemNum">3</span>送信完了</li>
  </ul>
  <p>必要事項を入力し、「入力内容を確認する」ボタンを押してください。</p>
 </div>
 <div class="mailForm">
  <div class="formBox pkg corporateName">
   <div class="formLabel">
    <label for="corporateName">法人名</label>
    <span class="required">必須</span> </div>
   <div class="formContent">
    <% if (validMap.get(Params.OTHER.CORPORATENAME) != null) { %>
    <em><%=validMap.get(Params.OTHER.CORPORATENAME) %></em><br />
    <% } %>
    <input type="text" name="<%=Params.OTHER.CORPORATENAME %>" id="corporateName" placeholder="例）株式会社カナミックネットワーク"  value="<%=getPal(request, Params.OTHER.CORPORATENAME) %>" />
   </div>
  </div>
  <div class="formBox pkg yourName">
   <div class="formLabel">
    <label for="yourName">ご担当者名</label>
    <span class="required">必須</span> </div>
   <div class="formContent">
    <% if (validMap.get(Params.OTHER.CHARGENAME) != null) { %>
    <em><%=validMap.get(Params.OTHER.CHARGENAME) %></em><br />
    <% } %>
    <input type="text" name="<%=Params.OTHER.CHARGENAME %>" id="yourName" placeholder="例）佐藤　花子" value="<%=getPal(request, Params.OTHER.CHARGENAME) %>" />
   </div>
  </div>
  <div class="formBox pkg mailAddress">
   <div class="formLabel">
    <label for="mailAddress">メールアドレス</label>
    <span class="required">必須</span> </div>
   <div class="formContent">
    <% if (validMap.get(Params.OTHER.MAIL) != null) { %>
    <em><%=validMap.get(Params.OTHER.MAIL) %></em><br />
    <% } %>
    <input type="text" name="<%=Params.OTHER.MAIL %>" id="mailAddress" placeholder="例）hanako@kanamic.net" value="<%=getPal(request, Params.OTHER.MAIL) %>" />
   </div>
  </div>
  <div class="formBox pkg city">
   <div class="formLabel">
    <label for="city">都道府県</label>
    <span class="required">必須</span> </div>
    <div class="formContent">
	<select name="<%=Params.OTHER.CITY %>">
	<option value="">未選択</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"北海道", false)%>>北海道</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"青森県", false)%>>青森県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"岩手県", false)%>>岩手県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"宮城県", false)%>>宮城県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"秋田県", false)%>>秋田県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"山形県", false)%>>山形県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"福島県", false)%>>福島県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"茨城県", false)%>>茨城県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"栃木県", false)%>>栃木県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"群馬県", false)%>>群馬県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"埼玉県", false)%>>埼玉県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"千葉県", false)%>>千葉県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"東京都", false)%>>東京都</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"神奈川県", false)%>>神奈川県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"山梨県", false)%>>山梨県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"長野県", false)%>>長野県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"新潟県", false)%>>新潟県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"富山県", false)%>>富山県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"石川県", false)%>>石川県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"福井県", false)%>>福井県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"岐阜県", false)%>>岐阜県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"静岡県", false)%>>静岡県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"愛知県", false)%>>愛知県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"三重県", false)%>>三重県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"滋賀県", false)%>>滋賀県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"京都府", false)%>>京都府</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"大阪府", false)%>>大阪府</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"兵庫県", false)%>>兵庫県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"奈良県", false)%>>奈良県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"和歌山県", false)%>>和歌山県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"鳥取県", false)%>>鳥取県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"島根県", false)%>>島根県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"岡山県", false)%>>岡山県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"広島県", false)%>>広島県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"山口県", false)%>>山口県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"徳島県", false)%>>徳島県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"香川県", false)%>>香川県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"愛媛県", false)%>>愛媛県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"高知県", false)%>>高知県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"福岡県", false)%>>福岡県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"佐賀県", false)%>>佐賀県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"長崎県", false)%>>長崎県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"熊本県", false)%>>熊本県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"大分県", false)%>>大分県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"宮崎県", false)%>>宮崎県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"鹿児島県", false)%>>鹿児島県</option>
	<option <%=choiced("selected='selected'",request,Params.OTHER.CITY,"沖縄県", false)%>>沖縄県</option>
	</select>
   </div>
  </div>
  <div class="formBox pkg phoneNumber">
   <div class="formLabel">
    <label for="phoneNumber">電話番号</label>
    <span class="required">必須</span> </div>
   <div class="formContent">
    <% if (validMap.get(Params.OTHER.TEL) != null) { %>
    <em><%=validMap.get(Params.OTHER.TEL) %></em><br />
    <% } %>
    <input type="text" name="<%=Params.OTHER.TEL %>" id="phoneNumber" placeholder="例）0357983955" class="js-characters-change" value="<%=getPal(request, Params.OTHER.TEL) %>" />
   </div>
  </div>
  <div class="formBox pkg formSubject">
   <div class="formLabel pkg">
    <label for="formSubject">お問い合せ内容</label>
    <span class="required">必須</span>
    <div class="irNotice">IRに関するお問合せはお電話でのみ承っております。<br />
     メールフォームからのお問合せには回答いたしかねます。</div>
   </div>
   <div class="formContent">
    <% if (validMap.get(Params.OTHER.INQUIRY) != null) { %>
    <em><%=validMap.get(Params.OTHER.INQUIRY) %></em><br />
    <% } %>
    <textarea id="formSubject" name="<%=Params.OTHER.INQUIRY %>"><%=getPal(request, Params.OTHER.INQUIRY) %></textarea>
   </div>
  </div>
 </div>
 <div class="agreement">
  <div class="policy">
	  <p><a href="../../company/request_privacy.html#sec01" target="_blank">個人情報の取り扱いについて</a><br>（必ず事前にご確認ください）</p>
  </div>
  <p class="agreeChk">
   <input type="checkbox" name="agreeChkReqOther" value="個人情報の取り扱いに同意します。" id="agreeChkReqOther" />
   <label for="agreeChkReqOther" class="chkBoxReqOther">個人情報の取り扱いに同意します。</label>
  </p>
  <div class="submit-container">
   <button type="submit" class="submit-button">入力内容を確認する</button>
  </div>
 </div>
 <input type="hidden" class="mailReqKbn" name="<%=Params.MAIL_REC_KBN %>"
  value="<%=DoText.purgeNull(request.getParameter(Params.MAIL_REC_KBN)) %>" />
</form>
<!-- /フォーム(その他お問い合わせ) --> 
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
<img height="1" width="1" src="https://www.googleadservices.com/pagead/conversion/1070139595/?value=1.0&label=Lead&script=0" alt=""/>
</noscript>
<footer>
 <p><small>Copyright c Kanamic Network Co.,LTD All Rights Reserved.</small></p>
</footer>
</body>

</html>