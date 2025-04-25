
$(function() {
    var topH = $('#page-top').offset().top;
    $(window).scroll(function() {
        if (topH - $(window).scrollTop() <0) {
            $('#page-top').addClass('header-fixed');
        } else {
            $('#page-top').removeClass('header-fixed');
        }
        
    })
});