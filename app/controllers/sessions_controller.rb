class SessionsController < ApplicationController

  def new
    # render text: "good work old bot"
  end

  def create
    if params[:password] == params[:password_confirm]
      render text: "#{params}"
    else
      render text: "Passwords don't match :("
    end
  end
end
