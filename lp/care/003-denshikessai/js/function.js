$(function() {    
    // ページ内スクロールリンク
    // ---------------------------------------
    $('a[href^=#]').click(function(){
		var speed = 500;
		var href= $(this).attr("href");
		var target = $(href == "#" || href == "" ? 'html' : href);
		var position = target.offset().top;
		// 移動先を調整する場合 var position = target.offset().top - 調整値;
		$("html, body").animate({scrollTop:position}, speed, "swing");
		return false;
	});
});