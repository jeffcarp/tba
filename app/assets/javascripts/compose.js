$(function(){
  var update_preview = function() {

    // Name
    if ($('#post_anon').is(':checked')) {
      $('section.reading .header').text('ANONYMOUS');
    } else {
      var user_name = $('.user-info').data('user-name');
      $('section.reading .header').text(user_name);
    }

    // Photo
    
    // Title
    $('.reading .title').text($('#post_title').val());

    // Body
    // TODO: needs simple format 
    $('.reading .body').html($('#post_content').val().replace(/\n/g, '<br />'));

  }

  // Triggers for update_preview
  $('#post_title').on('keyup', function() {
    update_preview();
  });
  $('#post_content').on('keyup', function() {
    update_preview();
  });
  $('#post_anon').on('change', function() {
    update_preview();
  });

  // Call on load
  update_preview();

});
