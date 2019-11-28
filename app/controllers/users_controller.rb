class UsersController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]
  
    def new
      @user = User.new
    end
  
    def create
      # normal create action
      @user = User.create(user_params)
      return redirect_to controller: 'users', action: 'new' unless @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    end
  
    def dashboard
      @user = current_user
      unless logged_in?
        redirect_to dashboard_path
      end
    end  
  
    private
  
    def user_params
      params.require(:user).permit(:first_name, :email, :password, :password_confirmation)
    end
  
  end
