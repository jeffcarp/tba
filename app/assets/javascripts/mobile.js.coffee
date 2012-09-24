opts = {
  lines: 13,
  length: 7,
  width: 4,
  radius: 10,
  rotate: 0,
  color: '#fff',
  speed: 1,
  trail: 60,
  shadow: true,
  hwaccel: false,
  className: 'spinner',
  zIndex: 2e9,
  top: 'auto',
  left: 'auto'
};

foo = () ->
  console.log("foo")


$ ->
  spinner = new Spinner(opts).spin()
  $("#loading").append(spinner.el)

$ ->
  $('body').attr('style', 'background: #222;')

  if ($('#loading').attr('data-partial'))
    partial = $('#loading').attr('data-partial')
    $.ajax(
      "/mobile/partial/"+partial,
      type: 'get'
      success: (data) ->
          $('#content').html('')
          $('body').attr('style', '')
          $('#content').append(data)
    )

