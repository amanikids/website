$.ajaxSetup({
  'beforeSend': function(xhr) { xhr.setRequestHeader('Accept', 'text/javascript') }
});

$(document).ready(function() {
  $('a[rel*=facebox]').facebox();
});

$(document).bind('reveal.facebox', function() {
  $('#facebox form').submit(function() {
    $.post($(this).attr('action'), $(this).serialize(), function(data) { $.facebox(data) })
    return false;
  })
})
