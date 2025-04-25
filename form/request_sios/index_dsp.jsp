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
				required : "カナミッククラウドサービス利用規約に同意していただければ先に進めます"
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
		<p>カナミッククラウドサービス利用規約の確認</p>
		<p>
			内容をご確認いただき、同意をチェック後、次へお進みください。<br> ※同意しない場合は次の画面に進めませんのでご注意ください。
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
			<li class="now">規約確認</li>
			<li>使用許諾</li>
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

.ruleBox ol.bracket>li {
	counter-increment: cnt;
	list-style-type: none;
}

.ruleBox ol.bracket>li:before {
	content: "(" counter(cnt) ") ";
	display: inline-block;
	margin-left: -1.5em;
	width: 1.5em;
}

.ruleBox>ol>li {
	list-style-type: decimal;
	margin-left: 2em;
}

.ruleBox li {
	line-height: 1.4;
	margin-bottom: 0.5em;
}

.ruleBox>p {
	margin: 1em;
}

.ruleBox ol.bracket {
	margin-left: 2em;
	margin-top: 0.5em;
}

.ruleBox ol {
	margin-bottom: 1em;
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
			<p>株式会社カナミックネットワーク（以下「当社」といいます）は、カナミッククラウドサービス利用規約（以下「本規約」といいます）を定め、これによりカナミッククラウドサービス（以下「本サービス」といいます）を当社と利用契約を締結した者およびその連携先の事業者に提供します。当社のプロバイダー規約は本規約に準じます。</p>
			<h3 id="no01">第１条（用語の定義）</h3>
			<p>本規約において、次の用語はそれぞれ次の意味で使用します。</p>
			<ol class="bracket">
				<li>「ユーザー」とは、次条に基づいて利用契約の申込を行い、当社と本サービスの利用契約を締結し、本サービスを利用する資格（以下「ユーザー資格」といいます）を得た者をいいます。</li>
				<li>「連携ユーザー」とは、あらかじめ当社の許可を受けて、ユーザーの職務の遂行に必要な範囲において、ユーザーと業務上連携して本サービスを利用するユーザー以外の第三者をいいます。</li>
				<li>「利用者」とは、ユーザーから各種介護サービスの提供を受ける者、各種医療サービスの提供を受ける者又はその他各種サービスの提供を受ける者をいいます。</li>
				<li>「スタッフ」とは、ユーザー又は連携ユーザーの業務に従事する者をいいます。</li>
			</ol>
			<h3 id="no02">第２条（利用契約の申込）</h3>
			<ol>
				<li>本サービスの利用を希望する者（以下「利用希望者」といいます）は、本規約を承認したうえで、当社が別途指定する手続きに従って、本サービスの利用を申し込み、当社がこれに承諾を行った時点でユーザーとなるものとします。</li>
				<li>当社は、利用希望者が以下の項目に該当すると判断した場合、当該申込みを承諾しない場合があります。
					<ol class="bracket">
						<li>利用希望者が日本国外に所在する場合。</li>
						<li>利用希望者が、過去に利用規約違反等により、ユーザー資格を取り消された場合。</li>
						<li>申込内容に虚偽、誤記又は記入もれがあった場合。</li>
						<li>仮差押、差押、競売、破産、民事再生、会社更正、特別清算の申し立てがなされている場合。</li>
						<li>手形交換所の取引停止処分を受けている場合、その他支払停止の状況にある場合。</li>
						<li>公租公課の滞納処分を受けている場合。</li>
						<li>その他、当社が利用希望者に利用を認めることを不適当と判断する場合。</li>
					</ol>
				</li>
				<li>利用希望者は、自己または自己の役員その他の関係者が反社会的勢力（暴力団、暴力団員、暴力団関係企業、総会屋、社会運動標ぼうゴロ、特殊知能暴力集団等をいう）でないこと、反社会的勢力ではなかったこと、反社会的勢力の威力等を用いないこと、反社会的勢力に対して資金を提供する等、反社会的勢力の維持運営に協力しないこと、その他反社会的勢力との間に社会的に非難されるべき関係を有しないことを表明し、保証しなければなりません。</li>
				<li>ユーザーは、連携ユーザーに本サービスを利用させるときは、当社が指定する方法により、あらかじめ当社の許可を得ることとします。</li>
			</ol>
			<h3 id="no03">第３条（ユーザーの責務）</h3>
			<ol>
				<li>ユーザーは、本規約を遵守するものとします。</li>
				<li>ユーザーは、ユーザー資格を第三者に対して譲渡等することができません。</li>
				<li>ユーザーは、いかなる方法においても、本サービスを通じて提供される情報又はファイルを第三者に対して使用させたり公開することができません。</li>
				<li>ユーザーが本サービスの利用に関連して当社に損害を及ぼした場合、当社に生じた一切の損害を賠償しなければなりません。</li>
			</ol>
			<h3 id="no04">第４条（本規約の範囲及び変更）</h3>
			<ol>
				<li>当社が別途規定する個別規定及び随時定める追加規定は、本規約の一部を構成します。本規約と個別規定又は追加規定が異なる場合には、個別規定又は追加規定が優先するものとします。</li>
				<li>当社は、ユーザーの承諾を得ることなく本規約を変更できます。変更後の規約は別段の定めがある場合を除き既存のユーザーにも適用されます。</li>
				<li>当社は、ホームページ等の掲示をもってユーザーに対して本規約の変更について通知をおこないます。</li>
				<li>本規約（個別規定及び追加規定を含む、以下同じ）は、契約成立日におけるユーザーと当社の間の合意を規定するものであり、契約締結前の検討段階若しくは契約締結後になされた口頭による申入れ、口頭による合意事項、又は当事者双方の代表者の記名押印のない文書類が、本規約の内容と相違する場合は、本規約の内容が優先されるものとします。</li>
				<li>
					本規約に記載されている内容は、本サービスに関する合意事項の全てであり、ユーザー及び当社は、本サービスに関し、本規約に定められている内容以上の義務及び責任を負担しないものとします。</li>
			</ol>
			<h3 id="no05">第５条（通知及び同意の方法）</h3>
			<ol>
				<li>当社からユーザーへの通知は、本規約に別段の定めがある場合を除き、本サービス経由の電子メール、本サービス上の一般掲示、またはその他当社が適当と認める方法によりされるものとします。</li>
				<li>前項の通知が電子メールで行われる場合、ユーザーの電子メールアドレス宛に発信し、ユーザーの電子メールアドレスを保有するサーバーに到着したことをもってユーザーへの通知が完了したものとみなします。ユーザーは、当社が電子メールで発信した通知を遅滞なく閲覧する義務を負うものとします。なお、電子メールの閲覧とは、ユーザーがそのサーバーに配置された電子メールを画面上に開示し、内容を確認することをいいます。</li>
				<li>第１項の通知が本サービス上の一般掲示で行われる場合、当該通知が本サービス上に掲示され、ユーザーが本サービスにアクセスすれば当該通知を閲覧することが可能となったときをもってユーザーへの通知が完了したものとみなします。</li>
				<li>当社が第1項ないし第3項によりユーザーに通知を行った場合、通知日より30日の経過をもって、同通知の内容についてユーザーの同意を得たものとみなします。</li>
			</ol>
			<h3 id="no06">第６条（ID及びパスワードの管理）</h3>
			<ol>
				<li>ユーザーは、本契約締結後、当社が付与するユーザーID（以下「ユーザーID」といいます）及びパスワードの管理責任を負うものとします。</li>
				<li>ユーザーは、ユーザーID及びパスワードを第三者に利用させたり、貸与、譲渡、名義変更、売買等をしてはならないものとします。</li>
				<li>ユーザーID及びパスワードの管理不十分、使用上の過誤、第三者の使用等による損害について、当社は一切責任を負いません。</li>
				<li>ユーザーは、ユーザーID及びパスワードが盗まれたり、第三者に使用されていることを知った場合には、直ちに当社にその旨を連絡するとともに、当社からの指示がある場合には、これに従うものとします。</li>
				<li>当社は、正当な理由のある場合、あらかじめユーザーに通知したうえで、ユーザー及び連携ユーザーによるIDの使用を停止あるいはIDを取り消すことができます。</li>
				<li>ユーザーは、当社の許可を受けて、連携ユーザーのためにID（以下「連携ID」といいます）を取得し、連携ユーザーに本サービスを使用させることができます。この場合、ユーザーは、連携ユーザーによる本サービスの利用について一切の責任を負わなければなりません。</li>
			</ol>
			<h3 id="no07">第７条（登録内容の変更届出）</h3>
			<ol>
				<li>ユーザーは、利用申込みにおいて届け出た内容に変更があった場合には、速やかに所定の書式による変更の届出を当社に行うものとします。</li>
				<li>ユーザーは、前項の届出を怠った場合、当社が従前の通知先に通知をおこなったときに通知が完了したものとみなします。</li>
			</ol>
			<h3 id="no08">第８条（本サービスの提供・変更・廃止）</h3>
			<ol>
				<li>本サービスのサービス提供地域は、日本全国とします。</li>
				<li>本サービスの内容は、原則として厚生労働省が通達等で定める基準等に準じるものとします。そのため、一部地域では、サービス内容と保険者が定める基準等が一致しない場合があります。</li>
				<li>本サービスはインターネット等の通信回線を経由して非独占的に提供されるサービスであるため、設備の性能、不具合、利用状況等により本サービスの品質に変化が生じることがあります。</li>
				<li>当社は、ユーザーに事前に通知したうえで、本サービスの内容の一部または全部の追加・変更をすることができます。</li>
				<li>当社は、ユーザーに事前に通知したうえで、本サービスの内容の一部または全部の廃止を行うことができます。</li>
				<li>本サービスの内容、変更及び廃止について、ユーザーは異議を申し立てることができません。また、当社が損害賠償義務等を負うことはありません。</li>
				<li>本サービス上において、ユーザーへ各種情報が提供される場合があります。そのことを、ユーザーは了承するものとします。</li>
			</ol>
			<h3 id="no09">第９条（本サービスの中止中断）</h3>
			<ol>
				<li>当社は、以下の事項に該当する場合、本サービスの運営を中止中断できるものとします。
					<ol class="bracket">
						<li>本サービスのシステムの保守を定期的に又は緊急に行う場合。</li>
						<li>戦争、暴動、騒乱、労働争議、地震、噴火、洪水、津波、火災、停電その他の不可抗力、第三者による加害行為（サイバーテロ等）等により、通常どおり本サービスを提供することができなくなった場合。</li>
						<li>通信回線の役務を提供する電気通信事業者が当該回線にかかる電気通信業務を停止した場合。</li>
						<li>その他、当社が本サービスの運営上のやむを得ない事情により中止中断を必要と判断した場合。</li>
					</ol>
				</li>
				<li>当社は、ユーザーにつき以下の各号の事由が生じたときは、本サービスの提供を停止できるものとします。
					<ol class="bracket">
						<li>ユーザーが期限までに利用料金等の支払いをおこなわない場合。</li>
						<li>ユーザーが本利用規約の各条項に違背した場合。</li>
						<li>前2号の他、当社の業務に著しい支障をきたし又はその恐れがあると判断する場合。</li>
					</ol>
				</li>
				<li>当社が前項の規定により本サービスの運営を中止中断するときは、あらかじめその旨をユーザーに通知するものとします。但し、緊急やむを得ない場合は、この限りではありません。</li>
				<li>当社は、本サービスの中止中断により、ユーザーまたは第三者が被ったいかなる損害について、理由を問わず一切の責任を負わないものとします。</li>
			</ol>
			<h3 id="no10">第１０条（利用料金等）</h3>
			<ol>
				<li>ユーザーは、当社が別途定める本サービスにかかる利用料金を支払うものとします。</li>
				<li>ユーザーは、月毎の利用料金を、前月の27日（27日が金融機関の休業日の場合は翌営業日）に自動引落にて支払うものとします。ただし、当社とユーザーとの間で利用料金の支払方法について別途合意した場合はそれに従います。</li>
				<li>前条に定める本サービスの提供の中止中断によりユーザーが本サービスを利用できない状態が生じた場合であっても、ユーザーは利用料の支払いを要するものとします。</li>
				<li>当社は、あらかじめユーザーに通知したうえで本サービスの利用料金を変更することができます。</li>
				<li>一旦支払われた利用料金は、理由の如何を問わず返還いたしません。</li>
			</ol>
			<h3 id="no11">第１１条（遅延損害金）</h3>
			<p>ユーザーが本サービスの利用料金を支払期日までに支払わない場合、支払期日の翌日から支払日まで年14.6％の割合の遅延損害金が加算されます。</p>
			<h3 id="no12">第１２条 （個人情報保護）</h3>
			<ol>
				<li>本サービスを提供する過程において当社が知り得た個人情報（個人に関する情報であって、当該情報に含まれる氏名、住所、生年月日、個人識別符号、その他の記述等によって特定の個人を識別できるもので、他の情報と容易に照合することができ、それによって特定の個人を識別することができることになるものを含む）に関し、当社は、以下の項目に該当する場合を除き第三者に対し開示しないものとします。
					<ol class="bracket">
						<li>情報の開示についてあらかじめ同意が得られている場合。</li>
						<li>法令により開示が求められた場合。</li>
						<li>人の生命、身体又は財産の保護のために必要がある場合であって、本人の同意を得ることが困難であるとき。</li>
						<li>公衆衛生の向上又は児童の健全な育成の推進のために特に必要がある場合であって、本人の同意を得ることが困難であるとき。</li>
						<li>国の機関若しくは地方公共団体又はその委託を受けた者が法令の定める事務を遂行することに対して協力する必要がある場合であって、本人の同意を得ることにより当該事務の遂行に支障を及ぼすおそれがあるとき。</li>
					</ol>
				</li>
				<li>当社は、個人情報を原則として5年間保存します。ただし、ユーザーがユーザー資格を喪失した場合、当社は当該ユーザーに関するすべての情報（個人情報を含む。）を前記保存期間内においても抹消することができます。</li>
				<li>当社は、ユーザー及び連携ユーザーが本サービス上にアップロードした情報又はファイルについて、バックアップ等の目的で複製することがあります。また、当社所定の保管期間を超えた場合、当社は本サービス上にアップロードされた情報又はファイルを削除することがあります。</li>
				<li>当社は、個人情報の漏洩、滅失又は毀損によって利用者、スタッフ、ユーザー、連携ユーザー又は介護サービス提供者に生じた損害について、当社に帰責事由がある場合を除き、一切責任を負いません。</li>
				<li>当社は、個人情報の取り扱いに関し、個人情報の保護に関する法律を順守し、当社規定のプライバシーポリシー（当社ホームページ等に掲載します。）に従って安全管理を行ないます。</li>
			</ol>
			<h3 id="no13">第１３条（個人情報の共同利用）</h3>
			<ol>
				<li>ユーザーは、利用者及びスタッフから個人情報を取得するに際し、ユーザー、連携ユーザー、当社が、当社プライバイシーポリシーに掲載された目的のため利用者及びスタッフの個人情報を本サービスにおいて共同して利用すること、ユーザー及び連携ユーザーが取得した個人情報は原則としてすべて共同利用の対象となること、並びに、ユーザーが当該個人情報の管理について責任を有することを利用者及びスタッフに対して通知することとします。</li>
				<li>当社は、個人情報を、個人情報の保護に関する法律（平成15年法律第57号）第36条以下に定める方法により個人が特定できない情報群に加工する場合があり、ユーザーはこれを了承するものとします。</li>
				<li>当社は、個人情報の利用目的を、当社HPに掲載するプライバシーポリシーにて公表し、その内容が変更されるときは速やかにプライバシーポリシーを改定してユーザー又は利用者に閲覧可能な状態に置くものとします。</li>
				<li>ユーザーは、利用者及びスタッフの個人情報を最新かつ正確な状態で管理するとともに、漏洩、滅失又は毀損の防止その他安全管理のために必要かつ適切な措置を講じなければなりません。</li>
				<li>ユーザーは、利用者及びスタッフから個人情報の開示を求められた場合には、法令の定めるところに従い、遅滞なく開示等の対応をしなければなりません。

			</ol>
			<h3 id="no14">第１４条（権利の帰属）</h3>
			<ol>
				<li>本サービスを構成するすべてのプログラム、ソフトウェア、サービス、手続き、商標、商号及びそれに付随する技術全般は、当社に帰属するものとします。</li>
				<li>本サービスの著作権は当社に帰属します。ユーザーは本サービス上にアップロードした情報又はファイルについて、著作権等の知的財産権、その他いかなる法的権利も、当社又は他のユーザーに対して主張しないものとします。</li>
				<li>ユーザーは、当社の許諾を得ないで、本サービスを通じて提供される情報又はファイルについて、著作権法で定めるユーザー個人の私的利用の範囲外の使用をすることはできません。ユーザーは、利用契約の解除又はユーザー資格の取り消し後も、当社の商標、商号及び著作権その他の知的財産権を侵害する行為、及び侵害するおそれがある一切の行為をおこなうことができません。</li>
				<li>ユーザーは、当社及び他のユーザー等に対し、本サービス上にアップロードした情報又はファイルについて著作者人格権を行使しないものとします。</li>
			</ol>
			<h3 id="no15">第１５条（自己責任の原則）</h3>
			<ol>
				<li>ユーザーは、自己の責任と負担において、本サービスを利用するために必要な通信機器、ソフトウェア、または電話利用契約等を準備するものとします。</li>
				<li>ユーザーは、アップロードした情報又はファイルについて生じたすべての法的な責任を負うものとします。</li>
				<li>
					ユーザーが本サービスの利用に伴い、第三者に対して損害を与え、又は第三者からクレーム等の連絡を受けた場合、自己の責任と費用において処理、解決するものとします。当社が、ユーザー又は連携ユーザーによる本サービスの利用に伴い、第三者からクレームその他の連絡又は損害賠償の請求等を受けた場合も同様とします。</li>
			</ol>
			<h3 id="no16">第１６条（免責事項）</h3>
			<ol>
				<li>本サービスの各機能は、使用開始日において当社が提供可能なものとし、本件使用がユーザーの特定の目的に適合すること、期待する性能を有すること、期待する成果を実現すること、不具合を起こさないこと、及び使用結果を含め、何らの保証を行うものではありません。</li>
				<li>当社は、本サービスの内容、及びユーザー又は連携ユーザーが本サービスを通じて得る情報等の完全性等については、いかなる保証も行わないものとします。</li>
				<li>当社以外の第三者が本サービス上に提供する情報について、当社はいかなる責任も負わないものとします。</li>
				<li>当社が本サービスの提供に関して損害賠償請求を負う場合においても、当社の損害賠償責任は、損害の原因及び内容の如何にかかわらず、現実に発生した通常かつ直接の損害に限られます。当社は、予見の有無を問わず、特別の事情から生じた損害、逸失利益及び第三者からの損害賠償請求に基づく損害について一切賠償責任を負いません。また、当社の損害賠償額は、当該ユーザーの月額利用料の１ヶ月分又は初期導入費のいずれか高い方の金額を上限とします。</li>
			</ol>
			<h3 id="no17">第１７条（禁止事項）</h3>
			<ol>
				<li>ユーザーは、本サービスの利用にあたって、以下の行為を行ってはならないものとします。
					<ol class="bracket">
						<li>他のユーザー、第三者もしくは当社の著作権又はその他の権利を侵害する行為、及び侵害するおそれのある行為。</li>
						<li>他のユーザー、第三者もしくは当社の財産又はプライバシーを侵害する行為、及び侵害するおそれのある行為。</li>
						<li>上記(1)(2)の他、他のユーザー、第三者もしくは当社に不利益又は損害を与える行為、及び与えるおそれのある行為。</li>
						<li>他のユーザー、第三者もしくは当社を誹謗中傷する行為。</li>
						<li>公序良俗に反する行為、又はそのおそれのある行為、もしくは公序良俗に反する情報を他のユーザー又は第三者に提供する行為。</li>
						<li>犯罪的行為、又は犯罪的行為に結び付く行為、もしくはそのおそれのある行為。</li>
						<li>ユーザーID及びパスワードを不正に使用する行為。</li>
						<li>コンピューターウィルス等の有害なプログラムを、本サービスを通じて又は本サービスに関連して使用もしくは提供する行為。</li>
						<li>本サービスに類似する事業を自らおこなうこと、及び、第三者におこなわせる行為。</li>
						<li>その他、法令に違反する若しくは違反するおそれのある行為。又は当社が不適切と判断する行為。</li>
					</ol>
				</li>
				<li>前項に該当するユーザーの行為によって当社又は第三者に損害が生じた場合、ユーザー資格を喪失した後であっても、ユーザーはすべての法的責任を負うものとします。</li>
			</ol>
			<h3 id="no18">第１８条（本サービスの利用期間・更新・中途解約）</h3>
			<ol>
				<li>本サービスの利用期間は、月額利用料発生の日から１年間とします。</li>
				<li>前項の規定にかかわらず、利用期間満了日の３ヶ月前までに当社又はユーザーのいずれからも何らの意思表示がない場合、契約は従前と同条件でさらに１年間更新されるものとし、以降も同様とします。</li>
				<li>ユーザーが利用期間の途中で契約の解約を希望する場合は、当社が指定する手続に従って、当社に解約申込みを行うものとします。</li>
				<li>ユーザーが利用期間の途中で契約を解約した場合、ユーザーは解約申込日以降の残存する利用期間の利用料金を、一括して支払うものとします。</li>
				<li>当社は、既に支払われた料金等の払戻義務を一切負いません。ユーザーが解約に伴って、当社に対して何らかの請求権を取得することはありません。</li>
				<li>更新拒絶又は中途解約した場合、当社は当該ユーザーに対するユーザーID及び連携IDの発行を拒否することができます。</li>
			</ol>
			<h3 id="no19">第１９条（ユーザー資格の取り消し）</h3>
			<ol>
				<li>ユーザーが以下の項目に該当する場合、当社は、事前に通知することなく、直ちに当該ユーザーのユーザー資格を取り消すことができます。
					<ol class="bracket">
						<li>利用契約の申込時に、虚偽の申告を行ったことが判明した場合。</li>
						<li>本ユーザー規約で禁止している事項に該当する行為を行った場合。</li>
						<li>利用料金等の支払債務の履行遅延又は不履行が1回でもあった場合。</li>
						<li>手段を問わず、本サービスの運営を妨害した場合。</li>
						<li>仮差押、差押、競売、破産、民事再生、会社更正、特別清算の申し立てがあった場合。</li>
						<li>手形交換所の取引停止処分を受けた場合、その他支払停止の状況にある場合。</li>
						<li>公租公課の滞納処分を受けた場合。</li>
						<li>その他、本規約に違反した場合。</li>
						<li>その他、ユーザーとして不適切と当社が判断した場合。</li>
					</ol>
				</li>
				<li>前項の規定により、当社がユーザー資格を取り消した場合、ユーザーは、当社に対する債務の全額を直ちに支払うものとします。</li>
			</ol>
			<h3 id="no20">第２０条（連携ユーザーの義務等）</h3>
			<ol>
				<li>連携ユーザーは、本規約の内容についてユーザーと同等の義務を負うものとします。ただし、本規約第６条第６項、第１０条、第１１条及び第１８条は連携ユーザーには適用されないものとします。</li>
				<li>当社は、連携ユーザーからの直接の問合せには応じないものとします。</li>
			</ol>
			<h3 id="no21">第２１条（協議）</h3>
			<p>本サービスに関連して、ユーザーと当社との間で紛争が生じた場合には、当該当事者がともに誠意をもって協議するものとします。</p>
			<h3 id="no22">第２２条（管轄裁判所）</h3>
			<p>本サービスに関するすべての紛争について、東京地方裁判所または東京簡易裁判所を第一審の専属管轄裁判所とします。</p>
			<h3 id="no23">付則：</h3>
			<div class="fusoku">
				<h4>第１条（効力発生日）</h4>
				<p>本規約は2000年10月20日より発効するものとします。</p>
				<h4>第２条（経過規定）</h4>
				<p>2018年1月1日以前に成立した契約について、第11条及び第18条は適用せず、従前の規定によるものとします。</p>
			</div>
			<p>最終改定：2018年1月1日</p>
		</div>
		<div class="agreement">
			<form class="mailFormWrapperReq formMailIn" name="reqPost"
				action="./agreement.jsp" method="post">
				<p class="agreeChk">
					<input type="checkbox" name="agreeChkReq" value="カナミッククラウドサービス利用規約に同意します。"
						id="agreeChkReq" /> <label for="agreeChkReq"
						class="chkBoxReqPost">カナミッククラウドサービス利用規約に同意します。</label>
				</p>
				<div class="submit-container">
					<button type="submit" class="submit-button">次へ</button>
				</div>
				<input type="hidden" class="formroot" name="<%=Params.NEXT1%>"
					value="<%=Params.NEXT1%>" />
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