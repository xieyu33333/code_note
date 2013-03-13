    user_agent = request.env['HTTP_USER_AGENT']
    if /iPhone/.match(user_agent) || /iPod/.match(user_agent) || /iPad/.match(user_agent)
      render :template => 'homes/downloadios', :layout => false
    elsif /Android/.match(user_agent)
      render :template => 'homes/downloadandroid', :layout => false
    else
      render :template => 'homes/downloadpc', :layout => false
    end