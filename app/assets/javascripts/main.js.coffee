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
    post_id = $(this).parent().data('post')
    $.post(
      "/votes",
      post_id: post_id
      success: (data) ->
        processVoteCallback(data, node)
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

processVoteCallback = (data, node) ->
  like_count_td = node.parent().parent().parent().find('.like_count')
  like_count = parseInt(like_count_td.attr('data-likes'))
  like_count = like_count + 1
  like_count_td.attr('data-likes', like_count)

  if like_count_td.hasClass('hidden')
    like_count_td.removeClass('hidden')

  like_count_td.html(like_count + " like")
  if like_count == 0 || like_count > 1
    like_count_td.html(like_count_td.html() + "s")

  node.parent().find('.upvoted').removeClass('hidden')
  node.parent().find('.upvote').addClass('hidden')

deleteVoteCallback = (data, node) ->
  like_count_td = node.parent().parent().parent().find('.like_count')
  like_count = parseInt(like_count_td.attr('data-likes'))
  like_count = like_count - 1
  like_count_td.attr('data-likes', like_count)

  if like_count == 0
    like_count_td.addClass('hidden')

  like_count_td.html(like_count + " like")
  if like_count == 0 || like_count > 1
    like_count_td.html(like_count_td.html() + "s")

  node.parent().find('.upvoted').addClass('hidden')
  node.parent().find('.upvote').removeClass('hidden')