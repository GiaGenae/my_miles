class UsersController < ApplicationController

  # GET: /users
  get "/users" do
    erb :"/users/index.html"
  end

  # GET: /users/signup
  get "/users/signup" do
    erb :"/users/signup.html"
  end

  # POST: /users
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

end
