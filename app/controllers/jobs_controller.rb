class JobsController < ApplicationController
  def index
    @current_user = User.find_by_id(session[:user_id])
    user_id = params[:user_id]
    if !user_id
      @jobs = Job.all
    else
      @jobs = Job.where(user_id:user_id)
    end
  end

  def show
    @current_user = User.find_by_id(session[:user_id])
    @job = Job.find(params[:id])
    @tenders = Tender.where(job_id: @job.id)
    @accepted_tender = Tender.where(job_id: @job.id, accepted: true)
  end

  def new
    @job = Job.new
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
#      render '/users/new.html.erb'
    end

  end
  def destroy
    @current_user = User.find_by_id(session[:user_id])
    job = Job.find_by_id(params[:id])
    # p @current_user
    # p params
    if @current_user && job
      if (@current_user == job.user)
        job.destroy
        flash.notice = "Job deleted"
        redirect_to user_jobs_path(@current_user)
      else
        flash.alert = "You are trying delete others job"
        redirect_to jobs_path(@current_user)
      end
    else
      flash.alert = "You should be logged in to delete jobs"
      redirect_to jobs_path
    end
  end

end
