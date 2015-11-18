class TendersController < ApplicationController
  rescue_from Mailgun::CommunicationError, with: :mail_not_send

  def index
    @user = User.find_by_id params[:user_id]
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
          url = request.base_url+ "/jobs/"+params[:job_id]
          #TODO check if we are banned
          UserMailer.tender_created_email(User.find(job.user_id), url).deliver_now
        else
          flash.alert = "You already applied for this job"
        end
        redirect_to user_tenders_path(user)
      else
        flash.notice = 'You need to be registered as a tradie to apply'
        redirect_to jobs_url
      end
    else
      flash.notice = 'You need to be logged in to register interest in a job'
      redirect_to jobs_url
    end
  end

  def update
    tender = Tender.find(params[:id])
    if params[:tender]
      tender.update(comment: params[:tender][:comment])
      redirect_to job_url(tender.job)
    else
    job_tenders = Tender.where(job_id: tender.job_id)
    job_tenders.each { |job| job.update(accepted: false)}
    tender.update(accepted: true)
    url = job_url(tender.job)
    UserMailer.tender_accepted_email(User.find(tender.user_id), url).deliver_now
    redirect_to job_url(tender.job)
    end
  end

  private
  def mail_not_send
    flash.alert = "Unfortunately the mail wasn't sent"
    redirect_to user_tenders_path(current_user)
  end


end
