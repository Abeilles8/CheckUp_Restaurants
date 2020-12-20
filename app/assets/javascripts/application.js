// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
// 
//= require jquery3
//= require popper
//= require bootstrap-sprockets
// 
//= require underscore

$(document).ready(function(){
  $('.your-class').slick({
    // setting-name: setting-value
  });
});

// 自動再生
$(function() {
    $('.autoplay').slick({
        // 表示枚数
        slidesToShow: 4,
        slidesToScroll: 1,
        // dots: true,
        autoplay: true,
        autoplaySpeed: 4500,
    });
});

$(function() {
  $('#star').raty({
		  size      :36,
		  starOff:    "/images/star-off.png",
		  starOn:    "/images/star-on.png",
		  starHalf:   "/images/star-half.png",
		  scoreName: "review[rate]",
		  //半分の入力を行う
		  half:       "true"
		});
});