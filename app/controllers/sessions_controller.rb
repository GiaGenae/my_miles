class SessionsController < ApplicationController

  # GET: /sessions
  get "/login" do
    redirect "/runs" if logged_in?
    erb :"/sessions/login.html"
  end

  # POST: /sessions
  post "/login" do
    user = User.find_by_username(params["user"]["username"])
    if user && user.authenticate(params["user"]["password"])
      session[:id] = user.id
      redirect "/runs"
    else
      flash[:error] = "Invalid credentials."
      redirect "/login"
    end
  end

  get "/logout" do
    session.clear
    redirect "/"
  end
end
