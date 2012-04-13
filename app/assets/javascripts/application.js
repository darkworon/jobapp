// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ui
//= require lazybox
//= require jquery_ujs
//= require jquery.jeditable.mini
//= require scripts



$(function() {
	$("#set_locale").change(function() {
		var url = $(this).val();
		window.location = url;
	});
	$("#pricelist_date_start,#pricelist_date_end").datepicker();
	$("#resume_birthdate,#user_birthdate").datepicker({changeMonth: true,
				changeYear: true, yearRange: '1910:2000', class: "calendar", id: "calendar"});
	$(".unactivated_new_order").click(function(){
		$.flash_notice("Для оформления подписки активируйте ваш аккаунт.", 3);
	});
	//$(".menu_item").pjax('[data-pjax-container]');

		
    var box = $('.backlink,.sticky_block'); // float-fixed block

    var top = box.offset().top - parseFloat(box.css('marginTop').replace(/auto/, 220));
    $(window).scroll(function(){
        var windowpos = $(window).scrollTop();
        if(windowpos < top) {
            box.css('position', 'absolute');
						box.css('visibility', 'hidden');
						box.css('top', 220);
        } else {
					  box.css('visibility', 'visible');
            box.css('position', 'fixed');
            box.css('top', 10);
        }
    });
});
$(function() {
	$.lazybox.settings = {overlay: true, modal: false, opacity: 0.1}

//$("a[data-remote]").live("click", function() {
	//$.getScript(this.href);
//	history.pushState({foo: 'bar'}, 'Title', this.href);
 // return false;
//});
});
$(document).ready(function() {
	//ajaxifyPagination();
	$("#set_locale").change(function() {
		var url = $(this).val();
		window.location = url;
	});
	$(".resend_act_email").click(function(){
		$(this).closest("div").show();
		$.flash_notice("Отправка письма активации...", 3);
	});
	
});

jQuery.fn.topLink = function(settings) {
  settings = jQuery.extend({
    min: 1,
    fadeSpeed: 200
  }, settings);
  return this.each(function() {
    //listen for scroll
    var el = $(this);
    el.hide(); //in case the user forgot
    $(window).scroll(function() {
      if($(window).scrollTop() >= settings.min)
      {
        el.fadeIn(settings.fadeSpeed);
      }
      else
      {
        el.fadeOut(settings.fadeSpeed);
      }
    });
  });
};
(function($){
  $.flash_notice = function(text,time){
  var id = Math.floor( Math.random( ) * (999 - 100 + 1) ) + 100;
  $('<div class="flash_notice" id="'+id+'" style="display:none;"><b>'+text+'</b></div>').prependTo('.flash').fadeIn("slow", function () {

    var timer;
	timer = setTimeout(function() {
	$(".flash #"+id).slideUp("slow", function(){
        $(this).remove();
	  });
	}, time*1000);
	$('.flash #'+id).mouseenter(function(){
		clearTimeout(timer);
		$(this).fadeTo(0, 1);
	}).mouseleave(function(){
		timer = setTimeout(function() {
	$(".flash #"+id).slideUp("slow", function(){
        $(this).remove();
	  });
	}, time*1000);
		$(this).fadeTo(0, 0.7);
	});

	$(".flash #"+id).click(function(){
      $(this).slideUp("slow", function(){
		clearTimeout(timer);
        $(this).remove();
      });
    });
  });
  }
  $.flash_error = function(text,time){
  var id = Math.floor( Math.random( ) * (999 - 100 + 1) ) + 100;
  $('<div class="flash_error" id="'+id+'" style="display:none;"><b>'+text+'</b></div>').prependTo('.flash').fadeIn("slow", function () {

    var timer;
	timer = setTimeout(function() {
	$(".flash #"+id).fadeOut("slow", function(){
        $(this).remove();
	  });
	}, time*1000);
	$('.flash #'+id).mouseenter(function(){
		clearTimeout(timer);
		$(this).fadeTo(0, 1);
	}).mouseleave(function(){
		timer = setTimeout(function() {
	$(".flash #"+id).fadeOut("slow", function(){
        $(this).remove();
	  });
	}, time*1000);
		$(this).fadeTo(0, 0.7);
	});

	$(".flash #"+id).click(function(){
      $(this).fadeOut("slow", function(){
		clearTimeout(timer);
        $(this).remove();
      });
    });
  });
  }
})(jQuery);
