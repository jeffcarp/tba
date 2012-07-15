$ ->
  $('#post_content').keyup () ->
    char_count = 500 - $('#post_content').val().length
    if char_count <= 150
      $('#char_counter').html('<p style="color: hsl(0, 100%, '+((150 - char_count)/3)+'%)">'+char_count+'</p>')
    else
      $('#char_counter').text(char_count)

# $ ->
#   $('input:checkbox').change () -> 
#     console.log('hm')
    
#     user_id = $(this).data('user-id')
    
#     $.post '/users/',
#       key_bindings: 'true'
#       (data) ->
#         $('#turn_key_bindings_on').hide()
#         $('#turn_key_bindings_off').show()
#         $('#key_bindings').show()
#         $('#key_bindings').data('key-bindings', true)

# $ ->
#   didEndDragging = () ->
#     console.log('OK')

#   $('#receive_checkbox').bind('dragend')