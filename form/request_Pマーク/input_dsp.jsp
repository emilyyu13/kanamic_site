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
<%
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
<link rel="start" href="https://www.kanamic.net/" title="Home" />
<link rel="Shortcut Icon" href="https://www.kanamic.net/favicon.ico" type="image/vnd.microsoft.icon" />
<link href="./reset.css" rel="stylesheet" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="./js/jquery.validate.min.js"></script>
<!-- 郵便番号→住所ライブラリ -->
<script src="https://ajaxzip3.github.io/ajaxzip3.js" charset="UTF-8"></script>

<!-- remodal -->
<link href="js/remodal/remodal.css" rel="stylesheet" type="text/css" />
<link href="js/remodal/remodal-default-theme.css" rel="stylesheet" type="text/css" />
<script src="js/remodal/remodal.min.js"></script>

<link href="./form_nomenu.css" rel="stylesheet" type="text/css" />

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
 <h1><img src="img/logo.png" /></h1>
</header>
<div id="thanks">
 <h1>資料請求・お問合せ</h1>
 <p>弊社にご関心をお持ちくださいまして、誠にありがとうございます。</p>
</div>
<div id="wrapper">
 <div id="contact">
  <div id="mailReq">
   <h2>メールでのお問合せ</h2>
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
 </div>
 <!-- /#contact -->
 <div id="irReq">
  <h2>IRのお問合せに関するご注意</h2>
  <p>IRに関するお問合せはお電話でのみ承っております。<br />
   メールフォームからのお問合せには回答いたしかねます。</p>
 </div>
</div>
<!-- /#wrapper -->

<%
if(request.getAttribute("validMap") != null) {
    validMap = (Map<String,String>)request.getAttribute("validMap");
%>
<!--p class="error">入力ミスがありました</p-->
<% }%>
<% //担当者名が入っている場合は入力内容を修正しに戻ってきたとみなす %>
<% if (getPal(request, Params.POST.CHARGENAME) == "" &&
       getPal(request, Params.DL.CHARGENAME) == "" &&
       getPal(request, Params.OTHER.CHARGENAME) == "") { %>
<!-- remodal表示 -->
<script type="text/javascript">
  $(function () {
    var inst = $('[data-remodal-id=modal]').remodal();
    inst.open();
  });
</script>
<% } %>

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
  <!-- <div class="policy">
	  <p><a href="../../company/privacy.html#sec01" target="_blank">個人情報の取り扱いについて</a><br>（必ず事前にご確認ください）</p>
  </div>
  <p class="agreeChk">
   <input type="checkbox" name="agreeChkReqPost" value="個人情報の取り扱いに同意します。" id="agreeChkReqPost" />
   <label for="agreeChkReqPost" class="chkBoxReqPost">個人情報の取り扱いに同意します。</label>
  </p> -->
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
  <!-- <div class="policy">
	  <p><a href="../../company/privacy.html#sec0" target="_blank">個人情報の取り扱いについて</a><br>（必ず事前にご確認ください）</p>
  </div>
  <p class="agreeChk">
   <input type="checkbox" name="agreeChkReqDL" value="個人情報の取り扱いに同意します。" id="agreeChkReqDL" />
   <label for="agreeChkReqDL" class="chkBoxReqDL">個人情報の取り扱いに同意します。</label>
  </p> -->
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
  <!-- <div class="policy">
	  <p><a href="../../company/privacy.html#sec01" target="_blank">個人情報の取り扱いについて</a><br>（必ず事前にご確認ください）</p>
  </div>
  <p class="agreeChk">
   <input type="checkbox" name="agreeChkReqOther" value="個人情報の取り扱いに同意します。" id="agreeChkReqOther" />
   <label for="agreeChkReqOther" class="chkBoxReqOther">個人情報の取り扱いに同意します。</label>
  </p> -->
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
<img height="1" width="1" src="https://www.googleadservices.com/pagead/conversion/1070139595/?value=1.0&label=Lead&script=0" />
</noscript>
<footer>
 <p><small>Copyright c Kanamic Network Co.,LTD All Rights Reserved.</small></p>
</footer>


<!-- モーダルコンテンツ -->
<div class="remodal remodal_large" data-remodal-id="modal" data-remodal-options="hashTracking: false, closeOnOutsideClick: false">
  <h2 class="ttlLL">個人情報の取り扱いについて</h2>
  <div class="modal_contents">
          <div class="section" id="sec01.5">
            <h2 class="ttlBgGrayNoSquare">I 個人情報の利用目的について</h2>
            <p>
              当社のサイトにて収集する個人情報は、次のような目的に使用されます。
            </p>
            <ul class="typeDisc">
              <li>ご購入商品のご利用サポート</li>
              <li>当社商品に関するサービス提供</li>
              <li>各種お問い合わせ及び資料送付</li>
              <li>ご購入商品または当社取り扱い商品の新情報の提供</li>
              <li>個人情報を特定しない統計情報への利用</li>
            </ul>
            <p>
              上記目的の範囲外で利用する場合は事前にお客様にお知らせし、ご了解をいただいた場合に限り利用させていただきます。
            </p>
          </div>
          <div class="section" id="sec02">
            <h2 class="ttlBgGrayNoSquare">II 個人情報の種類等について</h2>
            <p>弊社では以下の個人情報をお預かりしております。</p>
            <h3>【お問合せ関連】</h3>
            <p>
              当社に対するお問合せの際に、ご本人が記載または入力した勤務先、氏名、住所、電話番号、メールアドレス等
            </p>
            <h3>【採用関連】</h3>
            <p>
              申込者が記載した、氏名、性別、生年月日、年齢、郵便番号、住所、電話番号、携帯電話番号、メールアドレス、学校名、入年月、卒業(見込)年月保有する資格、職歴等
            </p>
            <h3>【カナミッククラウドサービス関連】</h3>
            <p>
              契約申込者が記載した、氏名、郵便番号、住所、電話番号等<br />
              カナミッククラウドサービスをご利用されている方が登録した、利用者様の医療・介護・福祉サービスに関する項目等
            </p>
            <h3>【広報・IR関連】</h3>
            <p>
              対象者が提供した、氏名、郵便番号、住所、電話番号、映像等<br />
            </p>
            <h3>【当社役員、顧問、従業員等関連】</h3>
            <p>履歴書、職務経歴書、家族情報、年金情報等<br /></p>
            <h3>【株主関連】</h3>
            <p>株主名、住所、株主番号、等<br /></p>
            <h3>【要配慮個人情報および機微（センシティブ）情報】</h3>
            <p>
              要配慮個人情報および機微（センシティブ）情報については、業務の適切な運営の確保その他必要と認められる目的以外で収集、保管または利用いたしません。
            </p>
          </div>
          <div class="section" id="sec03">
            <h2 class="ttlBgGrayNoSquare">III 個人情報の共同利用について</h2>
            <p>
              当社は、カナミックネットワークの経営資源を活用し、お客様に付加価値の高いサービスをご提供することを通じ、企業価値向上を図っております。<br />
              そのために以下の範囲内で必要な場合に限り、厳格な管理・監督のもとに個人情報を共同利用させていただきたいと考えておりますので、何卒ご理解を賜りますようお願い申し上げます。<br />
              なお、共同利用の取扱いにつきましては、今後必要に応じて見直しをさせていただくことがございます。その際には、あらかじめ当社ホームページに掲載するプライバシーポリシーにて公表させていただきます。
            </p>
            <h3>1. 共同利用する目的</h3>
            <ol>
              <li>(1) カナミッククラウドサービスおよびサポート提供のため</li>
              <li>
                (2) カナミッククラウドサービスのサービス品質向上を図るため
              </li>
              <li>
                (3)
                カナミッククラウドサービスをご契約いただいているお客様とのご契約履行のため
              </li>
              <li>(4) 公衆衛生の向上または児童の健全な育成の推進のため</li>
              <li>(5) 社会保障費適正化、科学的介護に向けた取組のため</li>
            </ol>
            <h3>2. 共同利用者範囲</h3>
            <p>
              以下の(1)～(3)の範囲の者が、個人情報を共同利用させていただきます。
            </p>
            <ol>
              <li>
                (1)
                当該個人情報を取得されたカナミッククラウドサービスのご契約者様（「ユーザー様」といいます。）
              </li>
              <li>
                (2)
                ユーザー様と連携して当該個人情報の主体であるご本人様に医療、介護またはその他サービス提供を行う業務に関わる方で、カナミッククラウドサービスを利用することにつきあらかじめユーザー様の指定を受け当社の許可を得ておられる方（「連携ユーザー様」といいます。）
              </li>
              <li>
                (3) 当社<br />
                ただし、ユーザー様および連携ユーザー様は、ご自身が医療、介護またはその他サービスを提供する対象となる方の個人情報のみご利用することができ、その他のカナミッククラウドサービスに収録された個人情報にアクセスし、これをご利用することはできません。
              </li>
            </ol>
            <h3>3. 共同利用個人データ項目</h3>
            <p>
              カナミッククラウドサービスに入力された個人データの項目はすべて共同で利用させていただく可能性がございますが、その場合も「１．共同利用する目的」に定める業務の遂行のために必要な最小限度において利用させていただきます。具体的には、氏名、性別、生年月日、住所、電話番号のほか、要介護度に関するデータ項目、医療・介護・福祉サービスの提供に関するデータ項目を共同で利用させていただく場合がございます。
            </p>
            <h3>4. 共同利用個人データの管理責任者名称</h3>
            <p>株式会社カナミックネットワーク</p>
            <h3>5. 個人情報の取得方法</h3>
            <p>
              共同利用する個人情報は、カナミッククラウドサービスご利用ユーザー様、ご利用ユーザー様が指定する連携ユーザー様がカナミッククラウドサービスに入力されたもの若しくはカナミッククラウドサービスご利用ユーザー様の委託によりシステム利用開始時に登録した遡及・移行データといたします。
            </p>
          </div>
          <div class="section" id="sec04">
            <h2 class="ttlBgGrayNoSquare">
              IV 個人情報の第三者への開示について
            </h2>
            <p>
              当社は、原則として、あらかじめご本人から同意をいただいている場合のほか、ご提供いただいた個人情報を第三者に提供・開示することはいたしません。<br />
              ただし、以下のような場合には、必要最小限度にて個人の情報を第三者に開示する場合がございます。
            </p>
            <ol class="typeDecimal">
              <li>法令に基づく場合</li>
              <li>
                人の生命、身体又は財産の保護のために必要がある場合であって、本人の同意を得ることが困難である場合
              </li>
              <li>
                公衆衛生の向上又は児童の健全な育成の推進のために特に必要がある場合であって、本人の同意を得ることが困難である場合
              </li>
              <li>
                国の機関若しくは地方公共団体又はその委託を受けた者が法令の定める事務を遂行することに対して協力する必要がある場合であって、本人の同意を得ることにより当該事務の遂行に支障を及ぼすおそれがある場合
              </li>
            </ol>
          </div>
          <div class="section" id="sec05">
            <h2 class="ttlBgGrayNoSquare">V 匿名加工情報</h2>
            <h3>1.匿名加工情報の作成・第三者提供について</h3>
            <p>
              当社は、カナミッククラウドサービスに係る以下の情報について、特定の個人を識別することおよび作成に用いる個人情報を復元することができないよう適切な保護措置を講じたうえで匿名加工情報として作成し、カナミッククラウドサービスおよびサポート提供、サービス品質向上、公衆衛生の向上、児童の健全な育成の推進又は社会保障費適正化、科学的介護に向けた取組のために第三者に提供することがございますので、公表いたします。
            </p>
            <h3>2.情報の項目</h3>
            <p>
              性別、生年月日のうち年月迄のデータ項目（ただしトップ（ボトム）コーディング処理したもの）住所のうち都道府県及び市郡区迄のデータ項目、要介護度に関するデータ項目、医療・介護・福祉サービスの提供に関するデータ項目
            </p>
            <h3>3.提供の方法</h3>
            <p>
              パスワードにより保護された電子ファイルを外部記憶媒体で手交もしくは当社提供のカナミッククラウドサービスの共有システムを利用
            </p>
          </div>
          <div class="section" id="sec06">
            <h2 class="ttlBgGrayNoSquare">VI 個人情報の保管期間について</h2>
            <p>
              弊社ではお預かりした個人情報を原則5年間保管させて頂いております。
              (※別途個別契約で5年以内に破棄する場合もございます。)保管期間が過ぎた個人情報に関しては、個人情報の媒体種類によってシュレッダー・溶解・データの完全消去等の適切な処置により破棄させていただいております。
            </p>
          </div>
          <div class="section" id="sec07">
            <h2 class="ttlBgGrayNoSquare">
              VII 個人情報を郵送する場合の注意点について
            </h2>
            <p>
              郵送等により個人情報の受け渡しを行う場合（CDやUSBメモリなどを郵送する場合）送付元の責任のもと、暗号化等の措置を行うものとします。<br />
              合わせて、お客様がデータを暗号化せずに郵送した場合に郵送事故などの弊社責任範囲外の原因により起こった情報漏洩に関しては弊社は一切責任を負わないものとします。<br />
              また、紙媒体などの暗号化できないものに関して、郵便事故などの弊社責任範囲外の原因により起こった情報漏洩に関しては弊社は一切責任を負わないものとします。
            </p>
          </div>
          <div class="section" id="sec08">
            <h2 class="ttlBgGrayNoSquare">
              VIII
              個人情報の開示・訂正・利用停止をご請求される場合の手続きについて
            </h2>
            <p>
              個人情報の開示・訂正・利用停止をご希望の方は[<a href="https://www.kanamic.net/pdf/privacy_demand.pdf" target="_blank">こちら</a>]をご覧下さい。<br />
              <a href="https://www.kanamic.net/pdf/privacy_demand.pdf" target="_blank">→個人情報の開示・訂正・利用停止をご請求される場合の手続きについて</a>
            </p>
          </div>
          <div class="section" id="sec10">
            <h2 class="ttlBgGrayNoSquare">著作権について</h2>
            <p>
              当サイト内で提供されるすべての情報やコーポレートマーク、商標、映像や画像などの著作権はカナミックネットワークに帰属します。<br />
              それら著作権保護対象物の取り扱い、及び使用に関しては下記の通りとします。
              個人的な利用に関しては、あくまでも第三者が閲覧可能な環境に流用されない、または営利的な目的で利用されないという前提において、表示、複製、印刷などは認められるものとしますが、改変などは認められません。また個人的な使用であっても著作権等に関するあらゆる表示を削除してはなりません。<br />
              また上記以外に該当する利用に関しては予め書面によって申請をし、カナミックネットワークの正式な許可を取った後でのみ、再利用し、複製し、再配布出来ます。ただし、あくまでも利用者の誤解を受けるような使用方法はお断り致します。
            </p>
          </div>
          <div class="section" id="sec11">
            <h2 class="ttlBgGrayNoSquare">クッキー(Cookie)について</h2>
            <p>
              弊社のサイトには、「クッキー（Cookie）」と呼ばれる技術を利用したページがあります。<br />
              クッキーとは、Webサーバからお客様のブラウザに送信される小規模なデータのことをいい、お客様のディスクにファイルとして格納されるものもあります。<br />
              クッキーの使用は業界の標準となっており、多くのサイトで、利用者に有益な機能を提供する目的で
              クッキーが使用されています。<br />
              クッキーにより、利用者の使用するコンピュータは特定されますが、利用者個人の身元を特定できるわけではありません。<br />
              なお、ブラウザの設定により、クッキーの設定を変更してクッキーの機能を無効にすることができますが、その結果弊社ウェブページ上のサービスの一部がご利用いただけなくなることがあります。
            </p>
          </div>
          <div class="section" id="sec12">
            <h2 class="ttlBgGrayNoSquare">SSLについて</h2>
            <p>
              弊社のウェブサイトは、お客様の個人情報を保護するために「SSL（Secure
              Socket Layer）」に対応しています。<br />
              お客様が入力される個人情報を暗号化して送受信することで、高いレベルで安全性の確保を図っています。<br />
              ただし、お使いのウェブブラウザのSSLに関する設定が有効になっていない場合やSSLに対応していないブラウザをご利用の場合は、弊社のウェブサイトにアクセスできなかったり、情報の入力ができない場合があります。<br />
              ※ほとんどの主要なウェブブラウザはSSLに対応していますので、通常はお客様が特にSSLを意識される必要はありません。
            </p>
          </div>
          <div class="section" id="sec13">
            <h2 class="ttlBgGrayNoSquare">
              その他、ご確認及びご留意いただくこと
            </h2>
            <p>
              弊社のウェブサイトからリンクされている他社のウェブサイトにおけるプライバシー情報の取り扱いの基準や内容において、弊社は責任を負うものではありません。<br />
              弊社のウェブサイト以外のインターネットサイトでは、掲示板などでお客様が自発的に個人情報を開示した場合、その情報は他の利用者によって収集され使用されるおそれがあることにご留意ください。<br />
              従いまして、お客様はご自身の責任において情報を発信していただくとともに、取り扱いには十分にご注意くださいますようお願いいたします。
            </p>
          </div>
          <div class="section" id="sec13">
            <h2 class="ttlBgGrayNoSquare">認定個人情報保護団体について</h2>
            <p>
              当社は、個人情報の保護に関する法律に基づく下記の認定個人情報保護団体の会員となっております。
            </p>
            <ol style="margin-top: 1em;">
              <li>
                <a href="https://privacymark.jp/" target="_blank">一般財団法人 日本情報経済社会推進協会</a><br />
                個人情報に関する苦情・相談の申出先<br />
                【個人情報の取扱いに関する相談受付電話】<br />
                受付電話番号：0120-116-213／0120-700-779
              </li>
            </ol>
          </div>
          <!-- / .inner -->
  </div>

  <br>
  <div class="page_btn pkg">
    <ul>
      <li style="line-height: 2;">
        <input type="radio" name="agreement" value="1" id="agreement0" />
        <label for="agreement0" class="radioBtn">上記内容に同意する</label>
        </li>
        <li style="line-height: 2;">
        <input type="radio" name="agreement" value="0" id="agreement1" />
        <label for="agreement1" class="radioBtn">上記内容に同意しない</label>
      </li>
    </ul>
  </div>
  <div class="agreement" style="margin-top: 1em;">
    <div class="submit-container" style="margin-top: 0;">
      <button id="agreement0btn" class="back-button" style="display: none;" 
        onclick="location.href='https://www.kanamic.net/'">TOPページへ移動</button>
      <button id="agreement1btn" class="submit-button" style="display: none;" data-remodal-action="close">フォームを表示</button>
    </div>
    <script>
      $(function(){
        $('input[name="agreement"]').on("change",function () {
          if($(this).val() === "0"){
            $("#agreement1btn").hide();
            $("#agreement0btn").show();
          } else {
            $("#agreement0btn").hide();
            $("#agreement1btn").show();
          }
        });
      });

    </script>
  </div>

</div>
</body>
</html>