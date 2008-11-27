$.ajaxSetup({
  'beforeSend': function(xhr) { xhr.setRequestHeader('Accept', 'text/javascript') }
});

// ============================================================================
// = Facebox Stuff                                                            =
// ============================================================================
$(document).ready(function() {
  $('a[rel*=facebox]').facebox();

  $('input.to-facebox').each(function() {
    $(this).parents('form').submit(function(event) {
      event.preventDefault();
      $.facebox.loading();
      $.get($(this).attr('action'), null, function(data) { $.facebox(data) });
    });
  });
});

$(document).bind('reveal.facebox', function() {
  $('#facebox form').submit(function(event) {
    event.preventDefault();
    $.facebox.loading();
    $.post($(this).attr('action'), $(this).serialize(), function(data) { $.facebox(data) });
  })
});

// ============================================================================
// = Navigation Stuff                                                         =
// ============================================================================
$(document).ready(function() {
  $('.navigation .top').hover(function() { $(this).find('.children').show() }, function() { $(this).find('.children').hide() });
});

// ============================================================================
// = Slideshow Stuff                                                          =
// ============================================================================
jQuery.fn.nextSibling = function() {
  var children = $(this).parent().children();
  return children.eq((children.index(this) + 1) % children.length);
};

jQuery.fn.slideshow = function() {
  var currentSlide = $(this);
  currentSlide.siblings().css('z-index', '-2').end().css('z-index', '-1');
  setTimeout(function() {
    currentSlide.find('.caption').hide();
    currentSlide.fadeIn(1000, function() { // how long to take for the transition
      $(this).siblings().hide().end().find('.caption').show().end().nextSibling().slideshow();
    });
  }, 5000); // how long to show the slide
};

$(window).load(function() {
  $('.image').each(function() {
    if ($(this).children().size() > 1) {
      $(this).children().eq(1).slideshow();
    }
  });
});

// ============================================================================
// = Thumbnail Stuff                                                          =
// ============================================================================
$(document).ready(function() {
  $('.thumbnails').find('.current').each(function() {
    $(this).parent().scrollTop(($(this).prevAll().size() - 1) * 136);
  });
});
