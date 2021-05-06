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
      session["user_id"] = user.id
      redirect '/runs/new'
    else
      flash[:error] = user.errors.full_messages.first
      redirect '/users/signup'
    end
  end

  # # GET: /users/5
  # get "/users/:id" do
  #   erb :"/users/show.html"
  # end

  # # GET: /users/5/edit
  # get "/users/:id/edit" do
  #   erb :"/users/edit.html"
  # end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end
end
