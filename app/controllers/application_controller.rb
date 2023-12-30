class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?
  helper_method :login_required

  def logged_in?
    session[:user_id]
  end

  def login_required
    unless logged_in?
      redirect_to login_path
    end
  end

  def administrator_required
    if logged_in?
      @current_user = current_user
      unless @current_user.role == 'Administrator'
        redirect_to main_path
      end
    else
      redirect_to main_path
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
