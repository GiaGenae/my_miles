class UsersController < ApplicationController

  get "/users" do
    erb :"/users/index.html"
  end

  get "/users/signup" do
    erb :"/users/signup.html"
  end

  post "/users/signup" do
    user = User.create(params["user"])
    if user.valid? 
      session[:id] = user.id
      redirect '/runs/new'
    else
      flash[:error] = user.errors.full_messages.first
      redirect '/users/signup'
    end
  end

  get "/login" do
    redirect "/runs" if logged_in?
    erb :"/users/login.html"
  end

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
