class ApplicationController < ActionController::Base
  private
  def log_in(user)
    session[:user_id] = user.id
  end

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access this page."
      redirect_to login_path
    end
  end

  def remember(user)
    user.remember
    cookies.signed[:user_id] = user.id
    cookies.permanent.encrypted[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
end
