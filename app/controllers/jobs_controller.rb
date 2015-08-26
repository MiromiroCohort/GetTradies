class JobsController < ApplicationController
  def index
    @jobs=Job.all
  end
  def show
    @job=Job.find(params[:id])
  end
  def new
    @job=Job.new
  end

  def create

    if session[:user_id]
      render text: "job params = #{params[:job]} current user email = #{User.find(session[:user_id]).email} #{User.find(session[:user_id]).profession}"
    else
      render text: "Please log in if you'd like to post a job"
    end

  end

end
