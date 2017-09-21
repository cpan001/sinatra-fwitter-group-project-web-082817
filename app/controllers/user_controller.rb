class UserController < ApplicationController

  #signup page
  get "/signup" do
    logged_in? ? (redirect "/tweets") : (erb :'users/create_user')
  end

  post "/signup" do
    @user = User.create(params)
    session[:user_id] = @user.id
    if params.any? {|k,v| v.empty?}
      redirect "/signup"
    else
      redirect "/tweets"
    end
  end

  #login
  get "/login" do
    logged_in? ? (redirect "/tweets") : (erb :'users/login')
  end

  post "/login" do
    @user = User.find_by(params)
    if @user
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  #logout
  get "/logout" do
    if logged_in?
      session.destroy
      redirect "/login"
    else
      redirect "/login"
    end
  end

  #show all tweets of a user
  get "/users/:name" do
    @user = User.find_by_slug(params[:name])
    erb :'users/show'
  end

end
