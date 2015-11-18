class JobsController < ApplicationController
  def index
    @jobs = if params[:search]
              Job.search(params[:search])
            elsif params[:user_id]
              @personal_list = true
              Job.where(user_id: params[:user_id])
            else
              Job.where(completed: false)
    end
  end

  def show
    @tendering_tradies = Hash.new
    @tender_changeable = true
    @job = Job.find(params[:id])
    Tender.where(job_id: @job.id).each do |tender|
      if tender.accepted
        @accepted_tender = tender
      else
        @tendering_tradies[User.find(tender.user_id)] = tender.id
      end
    end
    @accepted_tradie = User.where(id: @accepted_tender.user_id).first if @accepted_tender
    if @accepted_tender
      @tender_changeable = false if @accepted_tender.updated_at > 30.seconds.ago
    end
    if Tender.where(job_id: @job.id, rating: nil).length < Tender.where(job_id: @job.id).length
      @job_complete = true
    end
    @job_complete = false if Tender.where(job_id: @job.id).length == 0
  end

  def new
    if current_user = User.find_by_id(session[:user_id])
      @job = Job.new
      @suburbs = ['Te Aro', 'Karori', 'Newtown', 'Island Bay', 'Kelburn', 'Kilbirnie', 'Khandallah', 'Hataitai', 'Miramar', 'Brooklyn', 'Petone', 'Johnsonville', 'Lyall Bay', 'Mount Cook', 'Mount Victoria', 'Oriental Bay', 'Seatoun', 'Thorndon']
    else
      redirect_to jobs_path
    end
  end

  def create
    puts user_id = session[:user_id]
    if session[:user_id]
      @job = Job.create(job_params)
      @job.update(:user_id => user_id)
    else
      flash.alert "Please log in if you'd like to post a job"
    end
    redirect_to jobs_path
  end

  def destroy
    job = Job.find_by_id(params[:id])
    if current_user && job
      if (current_user == job.user)
        job.destroy
        flash.notice = "Job deleted"
        redirect_to user_jobs_path(current_user)
      else
        flash.alert = "You are trying delete others job"
        redirect_to jobs_path(current_user)
      end
    else
      flash.alert = "You should be logged in to delete jobs"
      redirect_to jobs_path
    end
  end


  private

  def job_params
    params.require(:job).permit(:title, :location, :description, :image)
  end

end


