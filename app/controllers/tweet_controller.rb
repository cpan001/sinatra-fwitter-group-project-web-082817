class TweetController < ApplicationController

  #get all tweets
  get "/tweets" do
    @user = User.find_by(id: session[:user_id])
    logged_in? ? (erb :'tweets/tweets') : (redirect "/login")
  end

  #create new tweet
  get "/tweets/new" do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post "/tweets" do
    if params["content"].empty?
      redirect "/tweets/new"
    else
      @user = User.find_by(id: session[:user_id])
      @tweet = Tweet.new(content: params[:content])
      @user.tweets << @tweet
      @user.save
      redirect "/tweets"
    end
  end

  #delete tweet
  delete "/tweets/:id/delete" do
    @tweet = Tweet.find_by(id: params[:id])
    @user = User.find_by(id: session[:user_id])
    if @tweet.user == @user
      @tweet.destroy
      redirect "/tweets"
    else
      redirect "/tweets/#{@tweet.id}"
    end
  end

  #edit tweet
  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  patch "/tweets/:id" do
    @tweet = Tweet.find_by(id: params[:id])
    if !params[:content].empty?
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  #show single tweet
  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show_tweet'
    else
      redirect "/login"
    end
  end

end
