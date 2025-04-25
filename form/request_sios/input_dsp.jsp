<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="net.kanamic.website.requestSios.*"%>
<%@ page import="net.kanamic.framework.util.*"%>
<%@ page import="net.kanamic.framework.validator.*"%>
<%@ page import="java.util.*"%>
<%!/*** 宣言部 ***/
	//JSPの宣言は変換後のサーブレットのメンバとなるため、
	//その状態がコンテナで一意に扱われる。JSPの宣言で変数フィールド
	//を定義するとセッションにかかわらず一意の状態を維持するので
	//JSPの宣言における変数フィールドは注意が必要。

	//入力値を取得するローカルメソッド
	private String getPal(ServletRequest req, String palName) {
		return DoText.purgeNull(req.getParameter(palName));
	}
	//選択文字列を出力するメソッド
	private String choiced(String strOut, ServletRequest req, String pal, String val, boolean def) {
		String rtn = "";

		String[] ary = req.getParameterValues(pal);
		if (ary != null) {
			Arrays.sort(ary);//配列のソート
			if (Arrays.binarySearch(ary, val) >= 0) {
				rtn = strOut;
			} else if (def && ary.length == 0) {
				rtn = strOut;
			}
		} else if (def) {
			rtn = strOut;
		}
		return rtn;
	}%>
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

<%@ include file="ga_include.jsp"%>

<meta name="robots" content="noindex, nofollow">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-Language" content="ja" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="Description" content="カナミックネットワーク社会的自立支援アウトカム尺度申し込みフォームのページです。" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<meta name="copyright" content="http://www.kanamic.net" />
<title>社会的自立支援アウトカム尺度利用申請フォーム | 株式会社カナミックネットワーク</title>
<link rel="start" href="http://www.kanamic.net/" title="Home" />
<link rel="Shortcut Icon" href="http://www.kanamic.net/favicon.ico"
	type="image/vnd.microsoft.icon" />
<link href="./reset.css" rel="stylesheet" type="text/css" />
<link href="./form_nomenu.css" rel="stylesheet" type="text/css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="./js/jquery.validate.min.js"></script>
<!-- 郵便番号→住所ライブラリ -->
<script src="https://ajaxzip3.github.io/ajaxzip3.js" charset="UTF-8"></script>
<!-- フォームの半角?全角変換、ハイフン削除 -->
<script type="text/javascript">
	$(function() {
		$(".js-characters-change").each(function(i, elm) {
			$(elm).blur(function() {
				charactersChange($(this));
			});
		});
		charactersChange = function(ele) {
			var val = ele.val();
			var han = val.replace(/[Ａ-Ｚａ-ｚ０-９]/g, function(s) {
				return String.fromCharCode(s.charCodeAt(0) - 0xFEE0)
			});
			//ハイフン削除
			var han2 = han.replace(/[━‐―－\?ー\-]/g, '');

			$(ele).val(han2);
		}
	});
</script>
<script type="text/javascript">
	$(function() {
		//事業所番号チェック
		$("#chk_office").on("change",function() {
			if ( $(this).prop("checked") ) {
				$("#officeNo").val("なし");
				$("#officeNo").attr('readonly',true);
			} else {
				$("#officeNo").val("");
				$("#officeNo").attr('readonly',false);
			}
		});

		//初期表示
		if( "<%=getPal(request, Params.SIOS.OFFICE_NO)%>" === "なし" ){
			$("#chk_office").trigger("click");
		}
	$("#officeType").val("<%=getPal(request, Params.SIOS.OFFICE_TYPE)%>");

	});
</script>
<!-- フォームのバリデーション -->
<script type="text/javascript">
	(function() {
		//標準エラーメッセージの変更
		$.extend($.validator.messages, {
			email : '正しいメールアドレスの形式で入力して下さい',
			required : '入力必須です',
			phone : "正しい電話番号の形式で入力してください",
			zip : "正しい郵便番号の形式で入力してください"
		});
		//追加ルールの定義
		var methods = {
			phone : function(value, element) {
				return this.optional(element)
						|| /^\d{11}$|^\d{10}$|^\d{3}-\d{4}-\d{4}$/.test(value);
			},
			zip : function(value, element) {
				return this.optional(element)
						|| /^\d{7}$|^\d{3}-\d{4}$/.test(value);
			}
		};
		//メソッドの追加
		$.each(methods, function(key) {
			$.validator.addMethod(key, this);
		});
		//入力項目の検証ルール"rules"定義
		var rules = {
<%=Params.SIOS.CORPORATE_NAME%>  : {required : true},
<%=Params.SIOS.CORPORATE_NAMEKANA%>  : {required : true},
<%=Params.SIOS.REPRESENTATIVE_NAME%>  : {required : true},
<%=Params.SIOS.REPRESENTATIVE_NAMEKANA%>  : {required : true},
<%=Params.SIOS.CORPORATE_TEL%>  : {required : true,
				phone : true},
<%=Params.SIOS.CORPORATE_ADDNUM%>  : {required : true,
				zip : true},
<%=Params.SIOS.CORPORATE_ADD1%>  : {required : true},
<%=Params.SIOS.OFFICE_NAME%>  : {required : true},
<%=Params.SIOS.OFFICE_NAMEKANA%>  : {required : true},
<%=Params.SIOS.OFFICE_TYPE%>  : {required : true},
<%=Params.SIOS.OFFICE_NO%>  : {required : true},
<%=Params.SIOS.OFFICE_TEL%>  : {required : true,
				phone : true},

<%=Params.SIOS.OFFICE_ADDNUM%>  :{required : true,
				zip : true},
<%=Params.SIOS.OFFICE_ADD1%>  : {required : true},
<%=Params.SIOS.CHARGE_NAME%>  : {required : true},
<%=Params.SIOS.CHARGE_NAMEKANA%>  : {required : true},
<%=Params.SIOS.MAIL%>  :{required : true,
				email : true},
		};
		//入力項目ごとのエラーメッセージ定義
		var messages = {
			//エラーメッセージfor郵送フォーム
			//	corporateNameReqPost: {required: "法人名をご入力ください"},
			//    yourNameReqPost: {required: "ご担当者名をご入力ください"},
			//    phoneNumberReqPost: {required: "電話番号をご入力ください"},
			//	postalCode: {required: "郵便番号をご入力ください"},
			//    addr11ReqPost: {required: "住所をご入力ください"},
			//	agreeChkReqPost: {required: "個人情報の取り扱いに同意していただければ先に進めます"},
<%-- 			<%=Params.SIOS.CORPORATE_ADDNUM%>  : {
				required : "郵便番号をご入力ください",
				maxlength : "正しい郵便番号をご入力ください",
				minlength : "正しい郵便番号をご入力ください"
			},
			<%=Params.SIOS.OFFICE_ADDNUM%> : {
				required : "郵便番号をご入力ください",
				maxlength : "正しい郵便番号をご入力ください",
				minlength : "正しい郵便番号をご入力ください"
			}, --%>
					};
		//バリデート処理for郵送フォーム
		$(function() {
			$('.mailFormWrapperReqPost').validate({
				onfocusout : false,
				rules : rules,
				messages : messages,
				errorClass : "authError",
				errorElement : "span",
				highlight : function(element, errorClass) {
					$(element).addClass("formError");
				},
				unhighlight : function(element, validClass) {
					$(element).addClass("formValid");
				},
				//エラーメッセージ出力箇所調整
				errorPlacement : function(error, element) {
					element.before(error);
				}
			});
		});
	})();
</script>
<!--スマホ時のみ電話番号タップでCallする-->
<script type="text/javascript">
	if (navigator.userAgent.match(/(iPhone|iPad|iPod|Android)/)) {
		$(function() {
			$('.callNumber').each(
					function() {
						var str = $(this).html();
						if ($(this).children().is('img')) {
							$(this).html(
									$('<a>').attr(
											'href',
											'tel:'
													+ $(this).children().attr(
															'alt').replace(
															/-/g, '')).append(
											str + '</a>'));
						} else {
							$(this).html(
									$('<a>').attr(
											'href',
											'tel:'
													+ $(this).text().replace(
															/-/g, '')).append(
											str + '</a>'));
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
		<h1>
			<img src="img/logo.png" />
			<img src="img/logokz.png" class="logo2"/>
		</h1>
	</header>
	<div id="thanks">
		<h1>社会的自立支援アウトカム尺度<br>利用申請フォーム</h1>
		<p></p>
	</div>

	<%
		if (request.getAttribute("validMap") != null) {
			validMap = (Map<String, String>) request.getAttribute("validMap");
	%>
	<!--p class="error">入力ミスがありました</p-->
	<%
		}
	%>

	<!-- フォーム -->
	<form class="mailFormWrapperReqPost formMailIn" name="reqPost"
		action="./confirm.jsp" method="post">
		<div id="bredcrumbSec">
			<ul class="pkg" id="breadcrumb">
				<li>規約確認</li>
				<li>使用許諾</li>
				<li class="now">項目の入力</li>
				<li>入力内容の確認</li>
				<li>送信完了</li>
			</ul>
			<p>必要事項を入力し、「入力内容を確認する」ボタンを押してください。</p>
		</div>
		<div class="mailForm">
		<h2>法人情報</h2>
			<div class="formBox pkg corporateName">
				<div class="formLabel pkg">
					<label for="corporateName">法人名</label> <span class="required">必須</span>
				</div>
				<div class="formContent">
					<%
						if (validMap.get(Params.SIOS.CORPORATE_NAME) != null) {
					%>
					<em><%=validMap.get(Params.SIOS.CORPORATE_NAME)%></em><br />
					<%
						}
					%>
					<input type="text" name="<%=Params.SIOS.CORPORATE_NAME%>"
						id="corporateName" placeholder="例）株式会社カナミックネットワーク"
						value="<%=getPal(request, Params.SIOS.CORPORATE_NAME)%>" />
				</div>
			</div>
			<div class="formBox pkg corporateName">
				<div class="formLabel pkg">
					<label for="corporateNameKana">法人名（フリガナ）</label> <span class="required">必須</span>
				</div>
				<div class="formContent">
					<%
						if (validMap.get(Params.SIOS.CORPORATE_NAMEKANA) != null) {
					%>
					<em><%=validMap.get(Params.SIOS.CORPORATE_NAMEKANA)%></em><br />
					<%
						}
					%>
					<input type="text" name="<%=Params.SIOS.CORPORATE_NAMEKANA%>"
						id="corporateNameKana" placeholder="例）カブシキガイシャ　カナミックネットワーク"
						value="<%=getPal(request, Params.SIOS.CORPORATE_NAMEKANA)%>" />
				</div>
			</div>
			<div class="formBox pkg yourName">
				<div class="formLabel">
					<label for="representativeName">法人代表者氏名</label> <span class="required">必須</span>
				</div>
				<div class="formContent">
					<%
						if (validMap.get(Params.SIOS.REPRESENTATIVE_NAME) != null) {
					%>
					<em><%=validMap.get(Params.SIOS.REPRESENTATIVE_NAME)%></em><br />
					<%
						}
					%>
					<input type="text" name="<%=Params.SIOS.REPRESENTATIVE_NAME%>"
						id="representativeName" placeholder="例）加那　花子"
						value="<%=getPal(request, Params.SIOS.REPRESENTATIVE_NAME)%>" />
				</div>
			</div>
			<div class="formBox pkg yourName">
				<div class="formLabel">
					<label for=representativeNameKana>法人代表者氏名 （フリガナ）</label> <span class="required">必須</span>
				</div>
				<div class="formContent">
					<%
						if (validMap.get(Params.SIOS.REPRESENTATIVE_NAMEKANA) != null) {
					%>
					<em><%=validMap.get(Params.SIOS.REPRESENTATIVE_NAMEKANA)%></em><br />
					<%
						}
					%>
					<input type="text" name="<%=Params.SIOS.REPRESENTATIVE_NAMEKANA%>"
						id="representativeNameKana" placeholder="例）カナ　ハナコ"
						value="<%=getPal(request, Params.SIOS.REPRESENTATIVE_NAMEKANA)%>" />
				</div>
			</div>
			<div class="formBox pkg phoneNumber">
				<div class="formLabel">
					<label for="phoneNumber">法人電話番号</label> <span class="required">必須</span>
				</div>
				<div class="formContent">
					<%
						if (validMap.get(Params.SIOS.CORPORATE_TEL) != null) {
					%>
					<em><%=validMap.get(Params.SIOS.CORPORATE_TEL)%></em><br />
					<%
						}
					%>
					<input type="text" name="<%=Params.SIOS.CORPORATE_TEL%>" id="phoneNumber"
						placeholder="例）0312345678" class="js-characters-change"
						value="<%=getPal(request, Params.SIOS.CORPORATE_TEL)%>" />
				</div>
			</div>
			<div class="formBox pkg postalCode">
				<div class="formLabel">
					<label for="postalCode">法人郵便番号</label> <span class="required">必須</span>
				</div>
				<div class="formContent pkg">
					<%
						if (validMap.get(Params.SIOS.CORPORATE_ADDNUM) != null) {
					%>
					<em><%=validMap.get(Params.SIOS.CORPORATE_ADDNUM)%></em><br />
					<%
						}
					%>
					<input type="text" name="<%=Params.SIOS.CORPORATE_ADDNUM%>" id="postalCode1"
						placeholder="例）1506031" class="js-characters-change half"
						value="<%=getPal(request, Params.SIOS.CORPORATE_ADDNUM)%>" />
					<div class="postal2address-container"
						onClick="AjaxZip3.zip2addr('<%=Params.SIOS.CORPORATE_ADDNUM%>','','<%=Params.SIOS.CORPORATE_ADD1%>','<%=Params.SIOS.CORPORATE_ADD1%>');">
						<button type="button" class="postal2address-button">郵便番号から住所を検索</button>
					</div>
				</div>
			</div>
			<div class="formBox pkg address">
				<div class="formLabel">
					<label for="postalCode">法人住所</label> <span class="required">必須</span>
				</div>
				<div class="formContent">
					<%
						if (validMap.get(Params.SIOS.CORPORATE_ADD1) != null) {
					%>
					<em><%=validMap.get(Params.SIOS.CORPORATE_ADD1)%></em><br />
					<%
						}
					%>
					<input type="text" name="<%=Params.SIOS.CORPORATE_ADD1%>" id="addr1"
						placeholder="例）東京都渋谷区恵比寿4-20-3　恵比寿ガーデンプレイスタワー31階"
						value="<%=getPal(request, Params.SIOS.CORPORATE_ADD1)%>" />
				</div>
			</div>
		<h2 style="    margin-top: 40px;">事業所情報</h2>
			<div class="formBox pkg corporateName">
				<div class="formLabel pkg">
					<label for="corporateName">事業所名</label> <span class="required">必須</span>
				</div>
				<div class="formContent">
					<%
						if (validMap.get(Params.SIOS.OFFICE_NAME) != null) {
					%>
					<em><%=validMap.get(Params.SIOS.OFFICE_NAME)%></em><br />
					<%
						}
					%>
					<input type="text" name="<%=Params.SIOS.OFFICE_NAME%>"
						id="corporateName" placeholder="例）デイサービス　カナミック "
						value="<%=getPal(request, Params.SIOS.OFFICE_NAME)%>" />
				</div>
			</div>
			<div class="formBox pkg corporateName">
				<div class="formLabel pkg">
					<label for="corporateNameKana">事業所名（フリガナ）</label> <span class="required">必須</span>
				</div>
				<div class="formContent">
					<%
						if (validMap.get(Params.SIOS.OFFICE_NAMEKANA) != null) {
					%>
					<em><%=validMap.get(Params.SIOS.OFFICE_NAMEKANA)%></em><br />
					<%
						}
					%>
					<input type="text" name="<%=Params.SIOS.OFFICE_NAMEKANA%>"
						id="corporateNameKana" placeholder="例）デイサービス　カナミック "
						value="<%=getPal(request, Params.SIOS.OFFICE_NAMEKANA)%>" />
				</div>
			</div>
			<div class="formBox pkg phoneNumber">
				<div class="formLabel">
					<label for="phoneNumber">事業所種別</label> <span class="required">必須</span>
				</div>
				<div class="formContent">
					<%
						if (validMap.get(Params.SIOS.OFFICE_TYPE) != null) {
					%>
					<em><%=validMap.get(Params.SIOS.OFFICE_TYPE)%></em><br />
					<%
						}
					%>
					<select id="officeType" name="<%=Params.SIOS.OFFICE_TYPE%>">
					<option value="">選択してください</option>
					<option value="通所介護">通所介護</option>
					<option value="地域密着型通所介護">地域密着型通所介護</option>
					<option value="通所リハビリテーション">通所リハビリテーション</option>
					<option value="訪問リハビリテーション">訪問リハビリテーション</option>
					<option value="居住系サービス">居住系サービス</option>
					<option value="その他">その他</option>
				</select>
				</div>
			</div>
			<div class="formBox pkg phoneNumber">
				<div class="formLabel">
					<label for="phoneNumber">事業所番号</label> <span class="required">必須</span>
				</div>
				<div class="formContent">
					<%
						if (validMap.get(Params.SIOS.OFFICE_NO) != null) {
					%>
					<em><%=validMap.get(Params.SIOS.OFFICE_NO)%></em><br />
					<%
						}
					%>

					<input id="officeNo" type="text" name="<%=Params.SIOS.OFFICE_NO%>"
						placeholder="例）12345678901" class="half"
						value="<%=getPal(request, Params.SIOS.OFFICE_NO)%>" />
						<input type="checkbox" id="chk_office" /><label for="chk_office" class="chkBoxReqPost">なし</label>
				</div>
			</div>
			<div class="formBox pkg phoneNumber">
				<div class="formLabel">
					<label for="phoneNumber">事業所電話番号</label> <span class="required">必須</span>
				</div>
				<div class="formContent">
					<%
						if (validMap.get(Params.SIOS.OFFICE_TEL) != null) {
					%>
					<em><%=validMap.get(Params.SIOS.OFFICE_TEL)%></em><br />
					<%
						}
					%>
					<input type="text" name="<%=Params.SIOS.OFFICE_TEL%>" id="phoneNumber"
						placeholder="例）0357983955" class="js-characters-change"
						value="<%=getPal(request, Params.SIOS.OFFICE_TEL)%>" />
				</div>
			</div>
			<div class="formBox pkg phoneNumber">
				<div class="formLabel">
					<label for="phoneNumber">事業所FAX番号</label>
				</div>
				<div class="formContent">
					<%
						if (validMap.get(Params.SIOS.OFFICE_FAX) != null) {
					%>
					<em><%=validMap.get(Params.SIOS.OFFICE_FAX)%></em><br />
					<%
						}
					%>
					<input type="text" name="<%=Params.SIOS.OFFICE_FAX%>" id="FaxNumber"
						placeholder="例）0357983955" class="js-characters-change"
						value="<%=getPal(request, Params.SIOS.OFFICE_FAX)%>" />
				</div>
			</div>
			<div class="formBox pkg postalCode">
				<div class="formLabel">
					<label for="postalCode">事業所郵便番号</label> <span class="required">必須</span>
				</div>
				<div class="formContent pkg">
					<%
						if (validMap.get(Params.SIOS.OFFICE_ADDNUM) != null) {
					%>
					<em><%=validMap.get(Params.SIOS.OFFICE_ADDNUM)%></em><br />
					<%
						}
					%>
					<input type="text" name="<%=Params.SIOS.OFFICE_ADDNUM%>" id="postalCode2"
						placeholder="例）1506031" class="js-characters-change half"
						value="<%=getPal(request, Params.SIOS.OFFICE_ADDNUM)%>" />
					<div class="postal2address-container"
						onClick="AjaxZip3.zip2addr('<%=Params.SIOS.OFFICE_ADDNUM%>','','<%=Params.SIOS.OFFICE_ADD1%>','<%=Params.SIOS.OFFICE_ADD1%>');">
						<button type="button" class="postal2address-button">郵便番号から住所を検索</button>
					</div>
				</div>
			</div>
			<div class="formBox pkg address">
				<div class="formLabel">
					<label for="postalCode2">事業所住所</label> <span class="required">必須</span>
				</div>
				<div class="formContent">
					<%
						if (validMap.get(Params.SIOS.OFFICE_ADD1) != null) {
					%>
					<em><%=validMap.get(Params.SIOS.OFFICE_ADD1)%></em><br />
					<%
						}
					%>
					<input type="text" name="<%=Params.SIOS.OFFICE_ADD1%>" id="addr2"
						placeholder="例）東京都渋谷区恵比寿4-20-3　恵比寿ガーデンプレイスタワー31階"
						value="<%=getPal(request, Params.SIOS.OFFICE_ADD1)%>" />
				</div>
			</div>
			<div class="formBox pkg yourName">
				<div class="formLabel">
					<label for="chargeName">ご担当者名</label> <span class="required">必須</span>
				</div>
				<div class="formContent">
					<%
						if (validMap.get(Params.SIOS.CHARGE_NAME) != null) {
					%>
					<em><%=validMap.get(Params.SIOS.CHARGE_NAME)%></em><br />
					<%
						}
					%>
					<input type="text" name="<%=Params.SIOS.CHARGE_NAME%>"
						id="chargeName" placeholder="例）鈴木　太郎"
						value="<%=getPal(request, Params.SIOS.CHARGE_NAME)%>" />
				</div>
			</div>
			<div class="formBox pkg yourName">
				<div class="formLabel">
					<label for="chargeNameKana">ご担当者名 （フリガナ）</label> <span class="required">必須</span>
				</div>
				<div class="formContent">
					<%
						if (validMap.get(Params.SIOS.CHARGE_NAMEKANA) != null) {
					%>
					<em><%=validMap.get(Params.SIOS.CHARGE_NAMEKANA)%></em><br />
					<%
						}
					%>
					<input type="text" name="<%=Params.SIOS.CHARGE_NAMEKANA%>"
						id="chargeNameKana" placeholder="例）スズキ　タロウ"
						value="<%=getPal(request, Params.SIOS.CHARGE_NAMEKANA)%>" />
				</div>
			</div>
			<div class="formBox pkg mailAddress">
				<div class="formLabel">
					<label for="mailAddress">メールアドレス</label> <span class="required">必須</span>
				</div>
				<div class="formContent">
					<%
						if (validMap.get(Params.SIOS.MAIL) != null) {
					%>
					<em><%=validMap.get(Params.SIOS.MAIL)%></em><br />
					<%
						}
					%>
						<input type="text" name="<%=Params.SIOS.MAIL%>" id="mailAddress"
						placeholder="例）hanako@kanamic.net"
						value="<%=getPal(request, Params.SIOS.MAIL)%>" />
				</div>
			</div>
			<div class="formBox pkg formSubject">
				<div class="formLabel pkg">
					<label for="formSubject">備考</label>
				</div>
				<div class="formContent">
					<textarea id="formSubject" name="<%=Params.SIOS.BIKO%>"><%=getPal(request, Params.SIOS.BIKO)%></textarea>
				</div>
			</div>
		</div>
		<div class="agreement">
			<div class="submit-container">
				<button type="submit" class="submit-button">入力内容を確認する</button>
			</div>
		</div>
				<input type="hidden" class="formroot" name="<%=Params.NEXT3%>"
					value="<%=Params.NEXT3%>" />
	</form>
	<!-- /フォーム-->

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
	<script language="JavaScript"
		src="https://www.googleadservices.com/pagead/conversion.js">

	</script>
	<noscript>
		<img height="1" width="1"
			src="https://www.googleadservices.com/pagead/conversion/1070139595/?value=1.0&label=Lead&script=0" />
	</noscript>
	<footer>
		<p>
			<small>Copyright c Kanamic Network Co.,LTD All Rights
				Reserved.</small>
		</p>
	</footer>
</body>
</html>