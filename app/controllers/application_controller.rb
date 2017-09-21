require './config/environment'
require 'pry'
require 'sinatra'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  #helper
  def logged_in?
    !session[:user_id].nil?
  end

  #homepage
  get "/" do
    erb :index
  end

end
