// JavaScript Document

//ヘッダーのcssを変化させる
//$(function (){
//	$(window).on('scroll',function(){
//		const headerHeight = $('header').height();
//		
//		if ( headerHeight - 30 < $(this).scrollTop()){
//			$('.navi').addClass('scroll_navi');
//			$('.gnavi_list').addClass('scroll_gnavi_list');
//			$('.st0').css('fill', '#000000');
//			$('.st3').css('stroke', '#000000');
//			$('.st4').css('fill', '#000000');
//			$('.openbtn span').css('background-color', '#000000');
//		} else {
//			$('.navi').removeClass('scroll_navi');
//			$('.gnavi_list').removeClass('scroll_gnavi_list');
//			$('.st0').css('fill', '#ffffff');
//			$('.st3').css('stroke', '#ffffff');
//			$('.st4').css('fill', '#ffffff');
//			$('.openbtn span').css('background-color', '#ffffff');
//		}
//	});
//});

//任意のタブにURLからリンクするための設定
function GethashID (hashIDName){
	if(hashIDName){
		//タブ設定
		$('.tab li').find('a').each(function() { //タブ内のaタグ全てを取得
			var idName = $(this).attr('href'); //タブ内のaタグのリンク名（例）#lunchの値を取得	
			if(idName == hashIDName){ //リンク元の指定されたURLのハッシュタグ（例）http://example.com/#lunch←この#の値とタブ内のリンク名（例）#lunchが同じかをチェック
				var parentElm = $(this).parent(); //タブ内のaタグの親要素（li）を取得
				$('.tab li').removeClass("active"); //タブ内のliについているactiveクラスを取り除き
				$(parentElm).addClass("active"); //リンク元の指定されたURLのハッシュタグとタブ内のリンク名が同じであれば、liにactiveクラスを追加
				//表示させるエリア設定
				$(".area").removeClass("is-active"); //もともとついているis-activeクラスを取り除き
				$(hashIDName).addClass("is-active"); //表示させたいエリアのタブリンク名をクリックしたら、表示エリアにis-activeクラスを追加	
			}
		});
	}
}

//タブをクリックしたら
$('.tab a').on('click', function() {
	var idName = $(this).attr('href'); //タブ内のリンク名を取得	
	GethashID (idName);//設定したタブの読み込みと
	return false;//aタグを無効にする
});

// 上記の動きをページが読み込まれたらすぐに動かす
$(window).on('load', function () {
    $('.tab li:first-of-type').addClass("active"); //最初のliにactiveクラスを追加
    $('.area:first-of-type').addClass("is-active"); //最初の.areaにis-activeクラスを追加
	var hashName = location.hash; //リンク元の指定されたURLのハッシュタグを取得
	GethashID (hashName);//設定したタブの読み込み
});

$(function (){
	$(window).on('scroll',function(){
		const headerHeight = $('header').height();
		
		if ( headerHeight - 30 < $(this).scrollTop()){
			const src = $('.logo_img').children('img').attr('src').replace('white', 'black');
			$('.logo_img').children('img').attr('src', src);
			$('.logo_img_title').css('color', '#000000');
			$('.header_logo_img').css('border-right', '2px solid #000');
			$('.navi').addClass('scroll_navi');
			$('.gnavi_list').addClass('scroll_gnavi_list');
			$('.openbtn span').css('background-color', '#000000');
		} else {
			const srcwh = $('.logo_img').children('img').attr('src').replace('black', 'white');
			$('.logo_img').children('img').attr('src', srcwh);
			$('.logo_img_title').css('color', '#ffffff');
			$('.header_logo_img').css('border-right', '2px solid #fff');
			$('.navi').removeClass('scroll_navi');
			$('.gnavi_list').removeClass('scroll_gnavi_list');
			$('.openbtn span').css('background-color', '#ffffff');
		}
	});
});



//モーダルウィンドウ
$(function(){
  $(".md-btn").each(function(){
    $(this).on('click',function(e){
      e.preventDefault();
      var target = $(this).data('target');
      var modal = document.getElementById(target);
      $(modal).find('.md-overlay,.md-contents').fadeIn();
    });
  });
  $('.md-close').on('click',function(){
    $('.md-overlay,.md-contents').fadeOut();
  });
});


//スマホ版ナビゲーション
$(".openbtn").click(function () {//ボタンがクリックされたら
	$(this).toggleClass('active');//ボタン自身に activeクラスを付与し
    $("#mb_g-nav").toggleClass('panelactive');//ナビゲーションにpanelactiveクラスを付与
});

$("#mb_g-nav a").click(function () {//ナビゲーションのリンクがクリックされたら
    $(".openbtn").removeClass('active');//ボタンの activeクラスを除去し
    $("#mb_g-nav").removeClass('panelactive');//ナビゲーションのpanelactiveクラスも除去
});



//到達したら要素を表示させる
function showElementAnimation() {

  var element = document.getElementsByClassName('js-animation');
  if(!element) return; // 要素がなかったら処理をキャンセル
  
  var showTiming = window.innerHeight > 768 ? 200 : 40; // 要素が出てくるタイミングはここで調整
  var scrollY = window.pageYOffset;
  var windowH = window.innerHeight;

  for(var i=0;i<element.length;i++) { var elemClientRect = element[i].getBoundingClientRect(); var elemY = scrollY + elemClientRect.top; if(scrollY + windowH - showTiming > elemY) {
      element[i].classList.add('is-show');
    } else if(scrollY + windowH < elemY) {
      // 上にスクロールして再度非表示にする場合はこちらを記述
      element[i].classList.remove('is-show');
    }
  }
}


showElementAnimation();
window.addEventListener('scroll', showElementAnimation);

//フェードインさせる要素を取得
const FADEIN_ELEM_R = document.getElementById('fadeinR');

//スクロール時に要素をフェードインさせるイベントを設定する
window.addEventListener('scroll', () => {
    //フェードインする要素の上部の位置を取得する
    const FADEIN_ELEM_R_TOP = FADEIN_ELEM_R.getBoundingClientRect().top;
    //ブラウザの高さを取得
    const WINDOW_HEIGHT_R = window.innerHeight;
    //画面に表示された時にフェードインさせる処理
    if (WINDOW_HEIGHT_R > (FADEIN_ELEM_R_TOP + 200)) {
        FADEIN_ELEM_R.classList.add('fadein-afterR');
    }else{
        FADEIN_ELEM_R.classList.remove('fadein-afterR');
    }
});
//フェードインさせる要素を取得
const FADEIN_ELEM_RR = document.getElementById('fadeinRR');

//スクロール時に要素をフェードインさせるイベントを設定する
window.addEventListener('scroll', () => {
    //フェードインする要素の上部の位置を取得する
    const FADEIN_ELEM_RR_TOP = FADEIN_ELEM_RR.getBoundingClientRect().top;
    //ブラウザの高さを取得
    const WINDOW_HEIGHT_RR = window.innerHeight;
    //画面に表示された時にフェードインさせる処理
    if (WINDOW_HEIGHT_RR > (FADEIN_ELEM_RR_TOP + 200)) {
        FADEIN_ELEM_RR.classList.add('fadein-afterR');
    }else{
        FADEIN_ELEM_RR.classList.remove('fadein-afterR');
    }
});
//フェードインさせる要素を取得
const FADEIN_ELEM_RRR = document.getElementById('fadeinRRR');

//スクロール時に要素をフェードインさせるイベントを設定する
window.addEventListener('scroll', () => {
    //フェードインする要素の上部の位置を取得する
    const FADEIN_ELEM_RRR_TOP = FADEIN_ELEM_RRR.getBoundingClientRect().top;
    //ブラウザの高さを取得
    const WINDOW_HEIGHT_RRR = window.innerHeight;
    //画面に表示された時にフェードインさせる処理
    if (WINDOW_HEIGHT_RRR > (FADEIN_ELEM_RRR_TOP + 200)) {
        FADEIN_ELEM_RRR.classList.add('fadein-afterR');
    }else{
        FADEIN_ELEM_RRR.classList.remove('fadein-afterR');
    }
});

//フェードインさせる要素を取得
const FADEIN_ELEM_L = document.getElementById('fadeinL');

//スクロール時に要素をフェードインさせるイベントを設定する
window.addEventListener('scroll', () => {
    //フェードインする要素の上部の位置を取得する
    const FADEIN_ELEM_L_TOP = FADEIN_ELEM_L.getBoundingClientRect().top;
    //ブラウザの高さを取得
    const WINDOW_HEIGHT_L = window.innerHeight;
    //画面に表示された時にフェードインさせる処理
    if (WINDOW_HEIGHT_L > (FADEIN_ELEM_L_TOP + 200)) {
        FADEIN_ELEM_L.classList.add('fadein-afterL');
    }else{
        FADEIN_ELEM_L.classList.remove('fadein-afterL');
    }
});
//フェードインさせる要素を取得
const FADEIN_ELEM_LL = document.getElementById('fadeinLL');

//スクロール時に要素をフェードインさせるイベントを設定する
window.addEventListener('scroll', () => {
    //フェードインする要素の上部の位置を取得する
    const FADEIN_ELEM_LL_TOP = FADEIN_ELEM_LL.getBoundingClientRect().top;
    //ブラウザの高さを取得
    const WINDOW_HEIGHT_LL = window.innerHeight;
    //画面に表示された時にフェードインさせる処理
    if (WINDOW_HEIGHT_LL > (FADEIN_ELEM_LL_TOP + 200)) {
        FADEIN_ELEM_LL.classList.add('fadein-afterL');
    }else{
        FADEIN_ELEM_LL.classList.remove('fadein-afterL');
    }
});
//フェードインさせる要素を取得
const FADEIN_ELEM_LLL = document.getElementById('fadeinLLL');

//スクロール時に要素をフェードインさせるイベントを設定する
window.addEventListener('scroll', () => {
    //フェードインする要素の上部の位置を取得する
    const FADEIN_ELEM_LLL_TOP = FADEIN_ELEM_LLL.getBoundingClientRect().top;
    //ブラウザの高さを取得
    const WINDOW_HEIGHT_LLL = window.innerHeight;
    //画面に表示された時にフェードインさせる処理
    if (WINDOW_HEIGHT_LLL > (FADEIN_ELEM_LLL_TOP + 200)) {
        FADEIN_ELEM_LLL.classList.add('fadein-afterL');
    }else{
        FADEIN_ELEM_LLL.classList.remove('fadein-afterL');
    }
});



//paginationJS
if(!navigator.userAgent.match(/(iPhone|iPad|iPod|Android)/)){
    //ここに書いた処理はスマホの時は無効
	$.scrollify({
		section : ".box",//1ページスクロールさせたいエリアクラス名
		scrollbars:"false",//スクロールバー表示・非表示設定
		interstitialSection : "#header",//ヘッダーフッターを認識し、1ページスクロールさせず表示されるように設定
		easing: "easeOutExpo", // 他にもlinearやeaseOutExpoといったjQueryのeasing指定可能
		scrollSpeed: 800, // スクロール時の速度

		//以下、ページネーション設定
		before:function(i,panels) {
		var ref = panels[i].attr("data-section-name");
		$(".pagination .active").removeClass("active");
		$(".pagination").find("a[href=\"#" + ref + "\"]").addClass("active");
		},
		afterRender:function() {
		var pagination = "<ul class=\"pagination\">";
		var activeClass = "";
		$(".box").each(function(i) {//1ページスクロールさせたいエリアクラス名を指定
		activeClass = "";
		if(i===$.scrollify.currentIndex()) {
		activeClass = "active";
		}
		pagination += "<li><a class=\"" + activeClass + "\" href=\"#" + $(this).attr("data-section-name") + "\"><span class=\"hover-text\">" + $(this).attr("data-section-name").charAt(0).toUpperCase() + $(this).attr("data-section-name").slice(1) + "</span></a></li>";
		});
		pagination += "</ul>";

		$("#box1").append(pagination);//はじめのエリアにページネーションを表示
		$(".pagination a").on("click",$.scrollify.move);
		}
});

$(window).on('load',function(){
    $("#splash-logo,#splash-loading").delay(1200).fadeOut('slow');//ロゴを1.2秒でフェードアウトする記述
    
    //=====ここからローディングエリア（splashエリア）を1.5秒でフェードアウトした後に動かしたいJSをまとめる
    $("#splash").delay(1500).fadeOut('slow',function(){//ローディングエリア（splashエリア）を1.5秒でフェードアウトする記述
    
    $('body').addClass('appear');//フェードアウト後bodyにappearクラス付与
    
    });
    //=====ここまでローディングエリア（splashエリア）を1.5秒でフェードアウトした後に動かしたいJSをまとめる
        
    
    
    //=====ここから背景が伸びた後に動かしたいJSをまとめたい場合は
    $('.splashbg').on('animationend', function() { 
    //この中に動かしたいJSを記載
    });
    //=====ここまで背景が伸びた後に動かしたいJSをまとめる
    
    });
}


$('.slider').slick({
		autoplay: true,//自動的に動き出すか。初期値はfalse。
		infinite: true,//スライドをループさせるかどうか。初期値はtrue。
		speed: 500,//スライドのスピード。初期値は300。
		slidesToShow: 2,//スライドを画面に3枚見せる
		slidesToScroll: 1,//1回のスクロールで1枚の写真を移動して見せる
		prevArrow: '<div class="slick-prev"></div>',//矢印部分PreviewのHTMLを変更
		nextArrow: '<div class="slick-next"></div>',//矢印部分NextのHTMLを変更
		centerMode: true,//要素を中央ぞろえにする
		variableWidth: true,//幅の違う画像の高さを揃えて表示
		dots: false,//下部ドットナビゲーションの表示
	});
