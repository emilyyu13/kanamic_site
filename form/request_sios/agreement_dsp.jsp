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
<!-- フォームのバリデーション -->
<script type="text/javascript">
	(function() {
		//標準エラーメッセージの変更
		$.extend($.validator.messages, {
			email : '正しいメールアドレスの形式で入力して下さい',
			required : '入力必須です',
			phone : "正しい電話番号の形式で入力してください"
		});
		//追加ルールの定義
		var methods = {
			phone : function(value, element) {
				return this.optional(element)
						|| /^\d{11}$|^\d{10}$|^\d{3}-\d{4}-\d{4}$/.test(value);
			}
		};
		//メソッドの追加
		$.each(methods, function(key) {
			$.validator.addMethod(key, this);
		});
		//入力項目の検証ルール"rules"定義
		var rules = {
			agreeChkReq : {
				required : true
			},
		};
		//入力項目ごとのエラーメッセージ定義
		var messages = {
			//エラーメッセージfor郵送フォーム
			//	corporateNameReqPost: {required: "法人名をご入力ください"},
			//    yourNameReqPost: {required: "ご担当者名をご入力ください"},
			//    phoneNumberReqPost: {required: "電話番号をご入力ください"},
			//	postalCodeReqPost: {required: "郵便番号をご入力ください"},
			//    addr11ReqPost: {required: "住所をご入力ください"},
			agreeChkReq : {
				required : "社会的自立支援アウトカム尺度使用を承諾していただければ先に進めます"
			},
			postalCodeReqPost : {
				required : "郵便番号をご入力ください",
				maxlength : "正しい郵便番号をご入力ください",
				minlength : "正しい郵便番号をご入力ください"
			},
		};
		//バリデート処理for郵送フォーム
		$(function() {
			$('.mailFormWrapperReq').validate({
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

		<p>社会的自立支援アウトカム尺度使用許諾の確認</p>
		<p>
			内容をご確認いただき、承諾をチェック後、次へお進みください。<br> ※承諾しない場合は次の画面に進めませんのでご注意ください。
		</p>
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
	<div id="bredcrumbSec">
		<ul class="pkg" id="breadcrumb">
			<li>規約確認</li>
			<li class="now">使用許諾</li>
			<li>項目の入力</li>
			<li>入力内容の確認</li>
			<li>送信完了</li>
		</ul>
	</div>

	<style>
.agreement {

}

div.ruleBox {
	margin: 0 auto 20px;
	padding: 15px;
	border: 1px solid #ccc;
	line-height: 1.4;
}

ol.indnt_1em,
ol.indnt_2em {
	list-style-type: none;
	margin-top: 0.5em;
	margin-left: 2em;
	margin-bottom: 0.5em;
}

ol.indnt_1em li {
	line-height: 1.4;
	margin-bottom: 0.5em;
	text-indent: -1.2em;
    margin-left: 1em;
}
ol.indnt_2em li {
	line-height: 1.4;
	margin-bottom: 0.5em;
	text-indent: -2em;
    margin-left: 2em;
}

.ruleBox>p {
	margin: 1em;
}


.ruleBox h3 {
	margin: 1em 1em 0.4em 1em;
	font-weight: bold;
}

.ruleBox h4 {
	margin: 1em 1em 0.4em 1em;
	font-weight: bold;
}

.fusoku {
	margin-left: 2em;
}

.fusoku p {
	margin-left: 1em;
	margin-bottom: 1em;
}
</style>
	<div class="mailForm">
		<div class="ruleBox">
			<!--    <div class="ruleMenu pkg">
     <ul>
      <li><a href="#no01">第１条（用語の定義）</a></li>
      <li><a href="#no02">第２条（利用契約の申込）</a> </li>
      <li><a href="#no03">第３条（ユーザーの責務）</a></li>
      <li><a href="#no04">第４条（本規約の範囲及び変更）</a></li>
      <li><a href="#no05">第５条（通知及び同意の方法）</a></li>
      <li><a href="#no06">第６条（ID及びパスワードの管理）</a></li>
      <li><a href="#no07">第７条（登録内容の変更届出）</a></li>
      <li><a href="#no08">第８条（本サービスの提供・変更・廃止）</a></li>
      <li><a href="#no09">第９条（本サービスの中止中断）</a></li>
      <li><a href="#no10">第１０条（利用料金等）</a></li>
      <li><a href="#no11">第１１条（遅延損害金）</a></li>
     </ul>
     <ul>
      <li><a href="#no12">第１２条 （個人情報保護） </a></li>
      <li><a href="#no13">第１３条（個人情報の共同利用）</a></li>
      <li><a href="#no14">第１４条（権利の帰属）</a></li>
      <li><a href="#no15">第１５条（自己責任の原則）</a></li>
      <li><a href="#no16">第１６条（免責事項）</a></li>
      <li><a href="#no17">第１７条（禁止事項）</a></li>
      <li><a href="#no18">第１８条（本サービスの利用期間・更新・中途解約）</a></li>
      <li><a href="#no19">第１９条（ユーザー資格の取り消し）</a></li>
      <li><a href="#no20">第２０条（連携ユーザーの義務等）</a></li>
      <li><a href="#no21">第２１条（協議）</a></li>
      <li><a href="#no22">第２２条（管轄裁判所）</a></li>
      <li><a href="#no23">付則</a></li>
     </ul>
    </div>-->

<p align="center">社会的自立支援アウトカム尺度使用許諾確認 </p>
<p>&nbsp;</p>
<p>使用者（以下「ユーザー」という）は株式会社カナミックネットワーク（以下「当社」という）が提供する、インターネット上のケア情報共有システム及び在宅ケア活動管理システム（カナミッククラウドサービス、以下「本サービス」といいます）の「社会的自立支援アウトカム尺度」を使用するにあたり、次の各条項を遵守します。 </p>
<h3>第１条 （目的物） </h3>
<p>ユーザーは、ユーザーの運営する介護保険事業所等において、自立支援ケアの実践を評価する目的、もしくは大学等研究機関において自立支援ケア等の研究目的で社会的自立支援アウトカム尺度を非独占的に使用できるものとする。 </p>
<h3>第２条 （著作権） </h3>
<p>社会的自立支援アウトカム尺度の著作権は株式会社楓の風（以下「楓の風」という）が有している。 </p>
<h3>第３条 （禁止行為） </h3>
<p>ユーザーは次の行為をしてはならない。 </p>
<ol class="indnt_2em">
  <li>一　前条の目的以外で社会的自立支援アウトカム尺度を使用すること </li>
  <li>二　社会的自立支援アウトカム尺度の使用権の譲渡又は再使用の許諾 <br>
  </li>
  <li>三　楓の風の許可なしに、社会的自立支援アウトカム尺度の化体した物・関連資料・マニュアル等を複製すること、又はそれらの占有を移転すること <br>
  </li>
  <li>四　社会的自立支援アウトカム尺度に関する機密若しくは知識の漏洩 <br>
  </li>
  <li>五　楓の風の指定した方法以外の方法で社会的自立支援アウトカム尺度を使用すること <br>
  </li>
  <li>六　社会的自立支援アウトカム尺度の変更 </li>
</ol>
<h3>第４条 （使用料） </h3>
<p>第１条の使用許諾の対価（使用料）は無償とする。 </p>
<h3>第５条 （保証） </h3>
<p>ユーザーは、社会的自立支援アウトカム尺度の使用によりユーザーが受けた一切の損害等にたいし、いかなる場合においても損害賠償責任を請求しない。 </p>
<h3>第６条 （化体物等の所有者等） </h3>
<p>ユーザーは、社会的自立支援アウトカム尺度の化体した物・資料・マニュアル等の一切の物の所有権が社会的自立支援アウトカム尺度の提供先である楓の風にあることを確認する。 </p>
<h3>第７条 （権利譲渡の禁止） </h3>
<p>ユーザーが社会的自立支援アウトカム尺度に改良を加え、若しくは改作した場合、その結果についての権利は社会的自立支援アウトカム尺度の提供先である楓の風に当然帰属し、ユーザーはその結果について、第三者に対して譲渡、使用権の設定、使用許諾、占有の移転等をしてはならない。 </p>
<h3>第８条 （使用の差し止め） </h3>
<p>ユーザーは、催告を要せず本契約を解除され、直ちに社会的自立支援アウトカム尺度の使用を差し止めされても異議を唱えない。 </p>
<h3>第９条 （契約の期間） </h3>
<p>社会的自立支援アウトカム尺度の利用可能期間は、申込契約調印の日から社会的自立支援アウトカム尺度のバージョン更新までの期間とする。新バージョン発表後は当社の発表する指示に従い、新バージョンスケールに使用を切り替える。 </p>
<h3>第１０条（個人情報保護） </h3>
<ol class="indnt_1em">
  <li>１．本サービスを提供する過程において当社が知り得た個人情報（個人に関する情報であって、当該情報に含まれる氏名、住所、生年月日、個人識別符号、その他の記述等によって特定の個人を識別できるもので、他の情報と容易に照合することができ、それによって特定の個人を識別することができることになるものを含む）に関し、当社は、以下の項目に該当する場合を除き第三者に対し開示しないものとします。 <br>
<ol class="indnt_1em">
  <li>（1）情報の開示についてあらかじめ同意が得られている場合。 <br>
  </li>
  <li>（2）法令により開示が求められた場合。 <br>
  </li>
  <li>（3）人の生命、身体又は財産の保護のために必要がある場合であって、本人の同意を得ることが困難であるとき。 <br>
  </li>
  <li>（4）公衆衛生の向上又は児童の健全な育成の推進のために特に必要がある場合であって、本人の同意を得ることが困難であるとき。 <br>
  </li>
  <li>（5）国の機関若しくは地方公共団体又はその委託を受けた者が法令の定める事務を遂行することに対して協力する必要がある場合であって、本人の同意を得ることにより当該事務の遂行に支障を及ぼすおそれがあるとき。 <br>
  </li>
</ol>
</li>
  <li>２．当社は、個人情報を原則として5年間保存します。ただし、ユーザーがユーザー資格を喪失した場合、当社は当該ユーザーに関するすべての情報（個人情報を含む。）を前記保存期間内においても抹消することができます。 <br>
  </li>
  <li>３．当社は、ユーザー及び連携ユーザーが本サービス上にアップロードした情報又はファイルについて、バックアップ等の目的で複製することがあります。また、当社所定の保管期間を超えた場合、当社は本サービス上にアップロードされた情報又はファイルを削除することがあります。 <br>
  </li>
  <li>４．当社は、個人情報の漏洩、滅失又は毀損によって利用者、スタッフ、ユーザー、連携ユーザー又は介護サービス提供者に生じた損害について、当社に帰責事由がある場合を除き、一切責任を負いません。 <br>
  </li>
  <li>５．当社は、個人情報の取り扱いに関し、個人情報の保護に関する法律を順守し、当社規定のプライバシーポリシー（当社ホームページ等に掲載します。）に従って安全管理を行ないます。 </li>
</ol>
<h3>第１１条（個人情報の共同利用） </h3>
<ol class="indnt_1em">
  <li>１．ユーザーは、利用者から個人情報を取得するに際し、ユーザー、当社が、当社プライバイシーポリシーに掲載された目的のため利用者及びスタッフの個人情報を本サービスにおいて共同して利用すること、ユーザーが取得した個人情報は原則としてすべて共同利用の対象となること、並びに、ユーザーが当該個人情報の管理について責任を有することを利用者に対して通知することとします。 <br>
  </li>
  <li>２．当社は、個人情報を、個人情報の保護に関する法律（平成15年法律第57号）第36条以下に定める方法により個人が特定できない情報群に加工する場合があり、ユーザーはこれを了承するものとします。 <br>
  </li>
  <li>３．当社は、個人情報の利用目的を、当社HPに掲載するプライバシーポリシーにて公表し、その内容が変更されるときは速やかにプライバシーポリシーを改定してユーザー又は利用者に閲覧可能な状態に置くものとします。 <br>
  </li>
  <li>４．ユーザーは、利用者の個人情報を最新かつ正確な状態で管理するとともに、漏洩、滅失又は毀損の防止その他安全管理のために必要かつ適切な措置を講じなければなりません。 <br>
  </li>
  <li>５．ユーザーは、利用者から個人情報の開示を求められた場合には、法令の定めるところに従い、遅滞なく開示等の対応をしなければなりません。 </li>
</ol>
<h3>第１２条（個人情報同意書） </h3>
<p>ユーザーは、社会的自立支援アウトカム尺度の利用にあたり個人情報等を入手するに際しては、利用者から個人情報の同意書を書面で得るものとする。なお、同意書には個人情報の利用目的を明記のうえ、利用者の氏名を自署するとともに、住所、性別、生年月日を記名するものとする。 </p>
<h3>第１３条（本サービスおよび社会的自立支援アウトカム尺度に関する問い合わせ先） </h3>
<p>本サービスの利用に関する問い合わせ先は当社とし、社会的自立支援アウトカム尺度の利用及び使用方法等に関する問い合わせ先は楓の風とする。なお、問い合わせ先に関する情報は本サービス上に掲示するものとする。 </p>
<h3>第１４条 （合意管轄裁判所） </h3>
<p>ユーザーは社会的自立支援アウトカム尺度利用に関する紛争の第一審管轄裁判所を東京地方裁判所とすることに合意する。 </p>
<h3>第１５条 （その他） </h3>
<p>本契約に定めのない事項については問い合わせの上、当社の指示に従う。 </p>

		</div>
		<div class="agreement">
			<form class="mailFormWrapperReq formMailIn" name="reqPost"
				action="./input.jsp" method="post">
				<p class="agreeChk">
					<input type="checkbox" name="agreeChkReq" value="社会的自立支援アウトカム尺度使用を承諾します。"
						id="agreeChkReq" /> <label for="agreeChkReq"
						class="chkBoxReqPost">社会的自立支援アウトカム尺度使用を承諾します。</label>
				</p>
				<div class="submit-container">
					<button type="submit" class="submit-button">次へ</button>
				</div>
				<input type="hidden" class="formroot" name="<%=Params.NEXT2%>"
					value="<%=Params.NEXT2%>" />
			</form>
			<!-- /フォーム-->
		</div>
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