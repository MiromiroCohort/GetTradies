class TendersController < ApplicationController
  def index

  end

  def create
    job=Job.find(params[:job_id])
    user=User.find_by_id(session[:user_id])
    if user&&job
      if user.profession != 'customer'
        Tender.create(job:job,user:user)
        flash.notice = 'You successfully applied for a job'
        # render text: "My jobs"
        redirect_to user_tenders_path(user)
      else
        flash.notice = 'You need to be registered as a tradie to apply'
        redirect_to jobs_url
      end
    else
      flash.notice = 'You should be logged in'
#      render '/users/_new.html.erb'
      redirect_to jobs_url
    end
    # params[:job_id]
  end


end
