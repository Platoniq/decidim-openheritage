//= require jquery.slick

$(document).ready(function(){
  $('.proposals-gallery').slick({
    // setting-name: setting-value
    adaptiveHeight: true,
    dots: true,
    // centerMode: true,
    // centerPadding: "30px",
    lazyLoad: 'ondemand'
  });
});
