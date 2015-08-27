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
      @job = Job.create(user_id: session[:user_id],
                        title: params[:job][:title],
                        location: params[:job][:location],
                        description: params[:job][:description])


      redirect_to "/jobs"
    else
      render text: "Please <a href='/sessions/new'>log-in</a> if you'd like to post a job"
    end

  end

end
