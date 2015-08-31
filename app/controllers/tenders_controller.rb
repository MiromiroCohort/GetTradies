class TendersController < ApplicationController
  def index
    @user = User.find_by_id params[:user_id]
    @current_user = User.find_by_id(session[:user_id])
    if !@user
      flash.alert = "You misspelled the path"
    else
       @tenders=Tender.where user_id:@user.id
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
#      render '/users/_new.html.erb'
      redirect_to jobs_url
    end
    # params[:job_id]
  end

  def update
    tender = Tender.find(params[:id])
    if params[:tender]
      # render text: "this is what you're looking for: #{params[:tender][:comment]}"
      tender.update(comment: params[:tender][:comment])
      redirect_to "/jobs/#{tender.job_id}"
    else
    job_tenders = Tender.where(job_id: tender.job_id)
    job_tenders.each { |job| job.update(accepted: false)}
    tender.update(accepted: true)
    redirect_to "/jobs/#{tender.job_id}"
    end
  end

end
