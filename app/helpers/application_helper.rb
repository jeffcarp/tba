module ApplicationHelper

  def current_controller?(name)
    return 'current' if controller.controller_name == name
  end

  def underline(path)
    if request.env['PATH_INFO'] == path
      return 'current'
    else
      return ' '
    end
  end

end
