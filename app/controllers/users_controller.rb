class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to login_path
    else
      render :new, status: 422
    end
  end

  def login
    
    @user = User.find_by(email: params[:email])
    if @user.present? && @user.authenticate(params[:password])
      log_in @user
      params[:remember_me] == "1" ? remember(@user) : forget(@user)
      redirect_to posts_path, notice: 'Login sucessfully...'
    else
      flash[:notice] = 'Invalid login....'
      redirect_to login_path
    end
  end

  def check_login; end

  def logout
    session.destroy
    flash[:notice] = 'You logout... :)'
    redirect_to login_path
  end

  private
  def user_params
    params.require(:user).permit( :username, :email, :password, :remember_token )
  end
end
