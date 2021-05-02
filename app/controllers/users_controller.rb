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
      flash[:success] = "Successfully created account!"
      session["user_id"] = user.id
      redirect '/runs'
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

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end
end