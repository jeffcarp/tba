$(function(){

  if (!$('.posts.compose').length) return false;

  var update_preview = function() {

    // Name
    if ($('#post_anon').is(':checked')) {
      $('section.reading .header').text('ANONYMOUS');
    } else {
      var user_name = $('.user-info').data('user-name');
      $('section.reading .header').text(user_name);
    }

    // Photo
    var photo_url = $('#post_photo_url').val();
    if (photo_url.length) {
      $('.reading .photo img').removeClass('hidden');
      $('.reading .photo img').attr('src', photo_url+"/convert?w=288");
    } else {
      $('.reading .photo img').addClass('hidden');
    }

    
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
  $('#post_photo_url').on('change', function() {
    update_preview();
  });

  // Call on load
  update_preview();

  // Cancel photo
  $('.cancel_photo').on('click', function() {
    var photo_url = $('input.photo_url');
    photo_url.val('');
    update_preview();
    $(this).hide();
  });



});
