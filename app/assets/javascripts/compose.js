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
    $('.filepicker').show();
    $('.photo_drag_drop').html('Or drop files here');
    var photo_url = $('input.photo_url');
    photo_url.val('');
    update_preview();
  });


  var handleFP = function(event) {
    $('.filepicker').hide();

    var file = event.fpfile;
      uploaded_photo = $('.uploaded_photo');
      uploaded_photo.children('img').attr('src', file.url+"/convert?w=600");
      uploaded_photo.show();

      $('input.photo_url').val(file.url);
  }

  // Load non-blocking filepicker API
  (function(a){if(window.filepicker){return}var b=a.createElement("script");b.type="text/javascript";b.async=!0;b.src=("https:"===a.location.protocol?"https:":"http:")+"//api.filepicker.io/v1/filepicker.js";var c=a.getElementsByTagName("script")[0];c.parentNode.insertBefore(b,c);var d={};d._queue=[];var e="pick,pickMultiple,read,write,writeUrl,export,convert,store,storeUrl,remove,stat,setKey,constructWidget,makeDropPane".split(",");var f=function(a,b){return function(){b.push([a,arguments])}};for(var g=0;g<e.length;g++){d[e[g]]=f(e[g],d._queue)}window.filepicker=d})(document);

});
