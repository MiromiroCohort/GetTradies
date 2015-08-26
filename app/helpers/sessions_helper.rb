module SessionsHelper
  def current_user
    User.find(cookies[:session_id][:value])
  end
end
