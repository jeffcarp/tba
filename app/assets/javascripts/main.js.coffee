$ ->
  $('#post_content').keyup () ->
    char_count = 500 - $('#post_content').val().length
    if char_count <= 150
      $('#char_counter').html('<p style="color: hsl(0, 100%, '+((150 - char_count)/3)+'%)">'+char_count+'</p>')
    else
      $('#char_counter').text(char_count)

$ ->
  $('.upvote, .downvote').click () ->
    node = $(this)
    up = ($(this).attr('class') == 'upvote') ? 'true' : 'false'
    post_id = $(this).parent().data('post')
    $.post(
      "/votes",
      post_id: post_id
      up: up
      success: (data) ->
        processVoteCallback(data, node, up)
    )

$ ->
  $('.upvoted, .downvoted').click () ->
    node = $(this)
    post_id = $(this).parent().data('post')
    console.log(post_id)
    $.ajax(
      "/votes/"+post_id+"/",
      type: 'delete'
      success: (data) ->
        deleteVoteCallback(data, node)
    )

processVoteCallback = (data, node, up) ->
  if up
    node.parent().find('.upvoted').removeClass('hidden')
  else
    node.parent().find('.downvoted').removeClass('hidden')
  node.parent().find('.upvote, .downvote').addClass('hidden')

deleteVoteCallback = (data, node) ->
  node.parent().find('.upvoted, .downvoted').addClass('hidden')
  node.parent().find('.upvote, .downvote').removeClass('hidden')