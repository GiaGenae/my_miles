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

  error Sinatra::NotFound do
    erb :"error.html"
  end

  helpers do
    def current_user
      @current_user ||= User.find(session[:id]) if session[:id]
    end

    def logged_in?
      !!current_user
    end

    def redirect_if_not_logged_in
      if !logged_in?
        flash[:error] = "Please login to access your runs."
        redirect "/login"
      end
    end

    def redirect_if_not_authorized
      @run = Run.find_by_id(params[:id])
      if current_user != @run.user
        redirect '/runs'
      end
    end
    
    def get_run
      @run = Run.find_by(params[:id])
    end
  end

end
