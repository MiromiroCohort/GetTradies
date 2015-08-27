class RatingsController < ApplicationController

  def new
    @job = Job.find(params[:job_id])
  end

  def create
    @tender = Tender.where(job_id: params[:job_id], accepted:true).first
    @tender.update(rating: params[:rating])

    render text: "#{params} session= #{session[:user_id]} tender rating = #{@tender.rating}"
  end

end
