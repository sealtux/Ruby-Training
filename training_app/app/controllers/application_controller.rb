class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :training_day, :current_user
  before_action :require_login

  private

  def training_day
    ENV.fetch("TRAINING_DAY", "6").to_i
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_login
    redirect_to login_path, alert: "Please sign in first." if training_day >= 9 && !current_user
  end

  def accessible_tasks
    training_day >= 9 ? current_user.tasks : Task.all
  end

  def accessible_events
    current_user.events
  end
end
