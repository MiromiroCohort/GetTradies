class TendersController < ApplicationController
  def index
    user = User.find_by_id params[:user_id]
    @current_user = User.find_by_id(session[:user_id])
    if !user
      flash.alert = "You misspelled the path"
    else
       @tenders=Tender.where user_id:user.id
    end

  end

  def create
    job=Job.find(params[:job_id])
    user=User.find_by_id(session[:user_id])
    if user&&job
      if user.profession != 'customer'
        if !job.tenders.find_by_user_id(user.id)
          Tender.create(job:job,user:user)
          flash.notice = 'You successfully applied for a job'
          # render text: "My jobs"
        else
          flash.alert = "You already applied for this job"
        end
        redirect_to user_tenders_path(user)
      else
        flash.notice = 'You need to be registered as a tradie to apply'
        redirect_to jobs_url
      end
    else
      flash.notice = 'You should be logged in'
      redirect_to jobs_url
    end
    # params[:job_id]
  end


end
