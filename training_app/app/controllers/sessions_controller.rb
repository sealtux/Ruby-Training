class SessionsController < ApplicationController
  skip_before_action :require_login, except: :destroy

  def new; end

  def new_registration
    @user = User.new
  end

  def register
    @user = User.new(params.require(:user).permit(:email, :password, :password_confirmation))
    if @user.save
      reset_session
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Account created."
    else
      render :new_registration, status: :unprocessable_entity
    end
  end

  def create
    user = User.find_by(email: params[:email].to_s.strip.downcase)
    if user&.authenticate(params[:password].to_s)
      reset_session
      session[:user_id] = user.id
      redirect_to root_path, notice: "Signed in."
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to login_path, notice: "Signed out.", status: :see_other
  end
end
