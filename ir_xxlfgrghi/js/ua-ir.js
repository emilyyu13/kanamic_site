// JavaScript Document

$(function(){
	// 右下のfloat-buttonを削除
		$("script[src$='common/js/float-button.js']").remove();
		$("div.float-button").remove();

	var prefix = "";
	
	var $dir = $("script")[1];
	$dir = $($dir).attr("src").split("/");
	
    if ( $dir[0].indexOf("common") == -1 ) {
		prefix += "../";
	}
	
    var agent = navigator.userAgent;
	//===================================androidの時=========================
    if(agent.search(/Android/) != -1){
		$("html").addClass("android");
	}
	//===================================スマホの時=========================
    if(agent.search(/iPhone/) != -1 ||  agent.search(/iPod/) != -1 || agent.search(/Android/) != -1){
	
		$("link[href='../common/css/style.css']").attr("href", "../common/css/sp.css");
		$("link[href='css/ir.css']").attr("href", "css/sp-ir.css");
		var script = document.createElement("script");
		script.setAttribute("type", "text/javascript");
		script.setAttribute("src", "../common/js/sp_init.js");
		document.getElementsByTagName("head")[0].appendChild(script);
		// link
		
		/*
		var link = '<link rel="stylesheet" href="/common/css/sp.css">';
		$('meta:last').after(link);
		*/
		var viewport = '<meta name="viewport" content="width=640">';
		$('meta:last').after(viewport);
		
		$(function(){
        $(".snav h1").on("click", function() {
            $(this).next().slideToggle();
            $(this).toggleClass("open");//追加部分
        });
    });
		
		
	//===================================PCユーザー,ipadの時=========================
	}else{
		var script = document.createElement("script");
		script.setAttribute("type", "text/javascript");
		script.setAttribute("src", prefix + "common/js/init.js");
		document.getElementsByTagName("head")[0].appendChild(script);
		var viewport = '<meta name="viewport" content="width=1100">';
		$('meta:last').after(viewport);
		if(agent.search(/iPad/) != -1 ){
			$("body").addClass("ipad");
		}
		//cssChange("/common/css/style.css")

	}
});




function cssChange( file ){
	var link = document.createElement('link');
	with( link ) {	
		href = file;
		type = 'text/css';
		rel = 'stylesheet';
	}
	var head = document.getElementsByTagName('head');
	head.item(0).appendChild(link);
}

