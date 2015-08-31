class RatingsController < ApplicationController

  def new
    @job = Job.find(params[:job_id])
  end

  def create
    @tender = Tender.where(job_id: params[:job_id], accepted:true).first
    @tender.update(rating: params[:rating])
    Job.find(@tender.job_id).update(completed: true)
    redirect_to "/jobs/#{@tender.job_id}"
  end

end
