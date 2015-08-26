module SessionsHelper

  def user_exists
    if User.find(cookies[:session_id])
      true
    else
      cookies[:session_id] = nil
      false
    end
  end

end
