$.ajaxSetup({
  'beforeSend': function(xhr) { xhr.setRequestHeader('Accept', 'text/javascript') }
});

// ============================================================================
// = Facebox Stuff                                                            =
// ============================================================================
$(document).ready(function() {
  $('a[rel*=facebox]').facebox();
});

$(document).bind('reveal.facebox', function() {
  $('#facebox form').submit(function() {
    $.facebox.loading();
    $.post($(this).attr('action'), $(this).serialize(), function(data) { $.facebox(data) });
    return false;
  })
});

// ============================================================================
// = Slideshow Stuff                                                          =
// ============================================================================
jQuery.fn.nextSibling = function() {
  var children = $(this).parent().children();
  return children.eq((children.index(this) + 1) % children.length);
};

jQuery.fn.slideshow = function() {
  $(this).siblings().css('z-index', '-2');
  $(this).css('z-index', '-1');

  var currentSlide = $(this);
  setTimeout(function() {
    currentSlide.fadeIn(1000, function() { // how long to take for the transition
      $(this).siblings().hide();
      $(this).nextSibling().slideshow();
    });
  }, 2000); // how long to show the slide
};

$(document).ready(function() {
  $('.slideshow').each(function() {
    $(this).children().eq(0).show();
  });
});

$(window).load(function() {
  $('.slideshow').each(function() {
    $(this).children().eq(1).slideshow();
  });
});