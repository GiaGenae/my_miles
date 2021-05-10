require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
    register Sinatra::Flash
  end

  get "/" do
    erb :welcome
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def redirect_if_not_logged_in
      if !logged_in?
        flash[:error] = "Please login to access your runs."
        redirect "/login"
      end
    end

    def current_user
      @user ||= User.find(session[:user_id])
    end
  end

  def redirect_if_not_authorized
    @run = Run.find_by_id(params[:id])
    if current_user != @run.user
      redirect '/runs'
    end
  end

end
