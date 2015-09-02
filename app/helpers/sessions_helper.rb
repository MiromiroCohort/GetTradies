module SessionsHelper

  def current_user
    User.find(session[:user_id]) if session[:id]
  end

  def user_exists
    if User.find(session[:user_id])
      true
    else
      session[:user_id] = nil
      false
    end
  end

end
