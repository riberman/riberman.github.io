(function($){
	$(document).ready(function(){
		$(window).scroll(function(){
        if ($(this).scrollTop() > 100) {
            $('#backTop').fadeIn();
        } else {
            $('#backTop').fadeOut();
        }
    });
    $('#backTop').click(function(){
        $("html, body").animate({ scrollTop: 0 }, 600);
        return false;
    });
	});
})(jQuery);
