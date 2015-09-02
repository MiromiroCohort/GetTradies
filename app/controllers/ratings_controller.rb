class RatingsController < ApplicationController

  def new
    @job = Job.find(params[:job_id])
  end

  def create
    @tender = Tender.where(job_id: params[:job_id], accepted:true).first
    @tender.update(rating: params[:rating])

    Job.find(@tender.job_id).update(completed: true)
    url = request.base_url+ "/jobs/"+@tender.job_id.to_s
    UserMailer.rating_email(User.find(@tender.user_id), url).deliver_now
    redirect_to "/jobs/#{@tender.job_id}"
  end

end
