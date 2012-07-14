module ApplicationHelper

  def underline(path)
    if request.env['PATH_INFO'] == path
      return 'current'
    else
      return ' '
    end
  end

end
