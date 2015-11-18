class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  before_action :current_path
  helper_method :current_user





  def current_user
    User.find_by(id: session[:user_id])
  end
  def current_path
    @current_path = request.path
  end

end
