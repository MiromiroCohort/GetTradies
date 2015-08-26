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

      # render text: "(user_id: #{session[:user_id]},
      #             title: #{params[:job][:title]},
      #             location: #{params[:job][:location]},
      #             description: #{params[:job][:description]})"
      render text: "job params = #{params[:job]} current user email = #{User.find(session[:user_id]).email} #{User.find(session[:user_id]).profession}. Job id = #{@job.id} Job may progress"
    else
      render text: "Please log-in if you'd like to post a job"
    end

  end

end
