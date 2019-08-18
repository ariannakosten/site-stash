class UsersController < ApplicationController
  
  get '/signup' do
    if logged_in?
      redirect '/home'
    else
      erb :'users/signup'
    end
  end
  
  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      flash[:field_error] = "** All fields are required **"
      redirect '/signup'
    else 
      @user = User.create(username: params[:username], password: params[:password])
      session[:user_id] = @user.id
      redirect '/home'
    end
  end 
  
  get '/login' do 
    if logged_in?
      redirect '/home' 
    else 
      erb :'users/login'
    end  
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/home'
    elseif params[:username] == "" || params[:password] == ""
       flash[:field_error] = "** A valid email & password are required **"
      redirect '/login'
    end
  end
  
  get '/home' do 
    if logged_in?
      @user = current_user
      erb :'users/home'
    else 
      redirect '/'
    end 
  end
  
  get '/logout' do
    if logged_in?
      session.clear
      flash[:message] = "** You have successfully been logged out **"
      redirect '/'
    else
      redirect '/'
    end
  end

end