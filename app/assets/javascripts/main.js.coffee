

# Global Search
# ===================================================================
$ ->

  global_search = $('.global_search')
  global_search_box = global_search.children('input')

  # Show search box when 'search' in nav is clicked
  $('.fire_global_search').on('click', (event) ->
    global_search.toggle()
    global_search_box.focus()
  )

  global_search_box.on('focusout', (event) ->
    # global_search.toggle()
  )

  # Show some results when user types in stuff
  global_search_box.on('keyup', (event) ->
    # console.log(global_search_box.val())
    q = global_search_box.val()
    if q.length < 3
      $('.global_search .results').html('')
      return
    $.ajax({
      url: '/search',
      data: { q: q },
      dataType: 'json',
      success: (data) ->
        populate_search_results(data, q)
    });
  )

  $('#post_content').keyup () ->
    char_count = 500 - $('#post_content').val().length
    if char_count <= 150
      $('#char_counter').html('<p style="color: hsl(0, 100%, '+((150 - char_count)/3)+'%)">'+char_count+'</p>')
    else
      $('#char_counter').text(char_count)

  $('.upvote, .downvote').click () ->
    node = $(this)
    post_id = $(this).parent().data('post')
    $.post(
      "/votes",
      post_id: post_id
      success: (data) ->
        processVoteCallback(data, node)
    )

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

populate_search_results = (data, query) ->
  search_results = $('.global_search .results')
  search_results.html('')
  if data.users.length
    search_results.append '<h3>USERS</h3>'
    $.each(data.users, (index, element) ->
      search_results.append '<div class="user" data-user-id="'+element.id+'">'+embolden_substring(element.name, query)+'</div>'
    )
  if data.posts.length
    search_results.append '<h3>POSTS</h3>'
    $.each(data.posts, (index, element) ->
      # word_array = element.content.split(' ')
      # boldened_content = embolden_substring(element.content, query)
      # console.log(query.split(' ')[0])
      # in_array = $.inArray(query.split(' ')[0], word_array)
      # console.log(in_array)
      search_results.append '<div class="post" data-post-id="'+element.id+'"><h4>'+embolden_substring(element.title, query)+'</h4><h5>'+element.formatted_date+' by '+element.user_name+'</h5><p>'+embolden_substring(element.content, query)+'</p></div>'
    )
  search_results.find('div').on('click', (event) ->
    if $(this).hasClass('user')
      window.location = '/users/'+$(this).attr('data-user-id')
  )

embolden_substring = (string, substring) ->
  string_lower = string.toLowerCase()
  substring_lower = substring.toLowerCase()
  return string if string_lower.indexOf(substring_lower) == -1
  boldened = ""
  boldened += string.substr(0, string_lower.indexOf(substring_lower))
  boldened += "<strong>"
  boldened += string.substr(string_lower.indexOf(substring_lower), substring_lower.length)
  boldened += "</strong>"
  boldened += string.substr(string_lower.indexOf(substring_lower) + substring_lower.length, string_lower.length)
  boldened = boldened.substr()
  return boldened

processVoteCallback = (data, node) ->
  like_count_td = node.parent().parent().parent().find('.like_count')
  like_count = parseInt(like_count_td.attr('data-likes'))
  like_count = like_count + 1
  like_count_td.attr('data-likes', like_count)

  if like_count_td.hasClass('hidden')
    like_count_td.removeClass('hidden')

  like_count_td.html(like_count)

  node.parent().find('.upvoted').removeClass('hidden')
  node.parent().find('.upvote').addClass('hidden')

deleteVoteCallback = (data, node) ->
  like_count_td = node.parent().parent().parent().find('.like_count')
  like_count = parseInt(like_count_td.attr('data-likes'))
  like_count = like_count - 1
  like_count_td.attr('data-likes', like_count)

  if like_count == 0
    like_count_td.addClass('hidden')

  like_count_td.html(like_count)

  node.parent().find('.upvoted').addClass('hidden')
  node.parent().find('.upvote').removeClass('hidden')