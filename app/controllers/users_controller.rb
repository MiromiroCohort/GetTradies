class UsersController < ApplicationController
  rescue_from Mailgun::CommunicationError, with: :mail_not_send

  def new
  end

  def create
    if !User.find_by_email(user_signup_params[:email])
       if user_signup_params[:password] == user_signup_params[:password_confirm]
        if verify_recaptcha
          @user = User.new(user_signup_params)
          @user.save
          session[:user_id] = @user.id
          url = request.base_url
          #TODO check if we are banned
          UserMailer.welcome_email(@user, url).deliver_now
          redirect_to edit_user_path(@user)
        else
          flash[:notice] = "Click the captcha, robut"
          redirect_to '/'
        end
       else
        flash[:notice] = "password must match."
        redirect_to '/'
       end
    else
      flash[:notice] = "email already assigned to account. Please log in."
      redirect_to '/'

    end
  end

  def index
    @users = User.all
    if session[:user_id]
      if User.find(session[:user_id]).profession == 'admin'
        @admin = true
      end
    end
  end

  def show
    if params[:id] != "show"
      if User.exists?(params[:id])
        @user = User.find(params[:id])
      else
        redirect_to "/"
      end
    else
      @user = User.find(session[:user_id])
    end
    @user_comments = Hash.new
    Tender.where(user_id: @user.id).each do |tender|
      if tender.comment
        comment = tender.comment
        @user_comments[comment] = User.find(Job.find(tender.job_id).user_id).username
      end
    end
  end

  def edit
    @suburbs = ['Te Aro', 'Karori', 'Newtown', 'Island Bay', 'Kelburn', 'Kilbirnie', 'Khandallah', 'Hataitai', 'Miramar', 'Brooklyn', 'Petone', 'Johnsonville', 'Lyall Bay', 'Mount Cook', 'Mount Victoria', 'Oriental Bay', 'Seatoun', 'Thorndon']
    @user = User.find(session[:user_id])
  end

  def update
    if @user = User.find(params[:id])
      @id = @user.id.to_s
      @user.update_attributes(user_update_params)
      flash[:notice] = "Your profile has been successfully updated"
      redirect_to jobs_path
    else
      render('edit')
    end

  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to '/users'
  end


  private

  def user_signup_params
    params.permit(:email, :password, :password_confirm)
  end

  def user_update_params
    params.require(:user).permit(:username, :given_name, :family_name, :email, :address, :phone_number, :profession, :description, :image)
  end

  def mail_not_send
    flash.alert = "Unfortunately the mail wasn't send"
    redirect_to edit_user_path(current_user)
  end


end
