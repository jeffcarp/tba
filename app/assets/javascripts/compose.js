$(function(){
  var update_preview = function() {

    if ($('#post_anon').is(':checked')) {
      $('section.reading .header').text('ANONYMOUS');
    } else {
      var user_name = $('.user-info').data('user-name');
      $('section.reading .header').text(user_name);
    }
  }


  $('#post_anon').on('change', function() {
    update_preview();
  });

  // Call on load
  update_preview();

});
