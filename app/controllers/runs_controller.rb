class RunsController < ApplicationController

  before ("/runs") do
    redirect_if_not_logged_in if request.path_info != "/login"
  end
  #CREATE

  get "/runs" do
    redirect_if_not_logged_in
    @runs = Run.all
    erb :"/runs/index.html"
  end

  get "/runs/new" do
    redirect_if_not_logged_in
    erb :"/runs/new.html"
  end

  post "/runs" do
    run = Run.create(params["run"])
    if run.valid?
      redirect "/runs"
    else
      flash[:error] = run.errors.full_messages.join(", ")
      redirect "/runs/new"
    end
  end

  #READ

  get "/runs/:id" do
    redirect_if_not_logged_in
    @run = Run.find(params["id"])
    erb :"/runs/show.html"
  end


  # GET: /runs/5/edit
  get "/runs/:id/edit" do
    erb :"/runs/edit.html"
  end

  # PATCH: /runs/5
  patch "/runs/:id" do
    redirect "/runs/:id"
  end

  # DELETE: /runs/5/delete
  delete "/runs/:id/delete" do
    redirect "/runs"
  end
end
