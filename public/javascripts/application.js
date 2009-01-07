$.ajaxSetup({
  'beforeSend': function(xhr) { xhr.setRequestHeader('Accept', 'text/javascript') }
});

// ============================================================================
// = Child Links Dropdown Stuff                                               =
// ============================================================================
$(document).ready(function() {
  $('.child_links_dropdown').change(function() {
    window.location = this.value;
  });
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
  currentSlide.siblings().css('z-index', '0').end().css('z-index', '1');
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
  $('.thumbnails ul').find('.current').each(function() {
    $('.thumbnails ul').scrollTop(($(this).prevAll().size()) * 136);
  });
});

$(document).ready(function() {
  $('.thumbnails .page').hover(function() {
    $(this).find('.caption').show();
  }, function() {
    $(this).find('.caption').hide();
  });
});

$(document).ready(function() {
  var scrollingTimeout;

  jQuery.fn.scrollBy = function(pixels, timeout) {
    var element = $(this);
    element.scrollTop($(this).scrollTop() + pixels);
    scrollingTimeout = setTimeout(function() { element.scrollBy(pixels, timeout) }, timeout);
  };

  $('.thumbnails .up').mousedown(function() {
    $('.thumbnails ul').scrollBy(-136, 300);
  });

  $('.thumbnails .down').mousedown(function() {
    $('.thumbnails ul').scrollBy(136, 300);
  });

  $('.thumbnails .arrow').mouseup(function() {
    clearTimeout(scrollingTimeout);
  });
});
