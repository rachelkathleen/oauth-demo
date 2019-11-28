class SessionsController < ApplicationController
    skip_before_action :require_login
  
    def new
      @user = User.new
      render :login
    end

    def welcome
        #show login buttons
    end
    
    def create
      # normal create action
      @user = User.find_or_create_by(email: params[:user][:email])
      if @user && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        redirect_to dashboard_path
      else
        flash[:error] = "Sorry, your username or password was incorrect"
        redirect_to '/login'
      end
    end
  
    def omniauth
      # google create action
      @user = User.from_omniauth(auth)
      @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    end
  
    def welcome
    end
  
    #logout
    def destroy
      session.clear
      redirect_to '/'
    end
  
    private
  
    def auth
      request.env['omniauth.auth']
    end
  end
