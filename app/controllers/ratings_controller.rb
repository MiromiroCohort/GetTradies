class RatingsController < ApplicationController
  rescue_from Mailgun::CommunicationError, with: :mail_not_send
  def new
    @job = Job.find(params[:job_id])
  end

  def create
    @tender = Tender.where(job_id: params[:job_id], accepted:true).first
    @tender.update(rating: params[:rating])

    Job.find(@tender.job_id).update(completed: true)
    url = jobs_url(@tender.job)
    #TODO check if we are banned
    UserMailer.rating_email(@tender.user, url).deliver_now

    redirect_to job_path(@tender.job)
  end
  private
  def mail_not_send
    flash.alert = "Unfortunately the mail wasn't send"
    redirect_to user_tenders_path(@tender.user)
  end

end
