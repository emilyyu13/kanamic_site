
$(function(){
    $(".langselect select").change(function() {
        var r = $('option:selected').val();
        var url = location.href;
        if(r === "1"){
            //日本語ページへ
            location.href = url.replace(/\/en\//gi, '\/ja\/');
        }　else if(r === "2"){
            //英語ページへ
            location.href = url.replace(/\/ja\//gi, '\/en\/');

        }
    });

});