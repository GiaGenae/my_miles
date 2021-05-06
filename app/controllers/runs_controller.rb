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
    run = current_user.runs.create(date: params[:run][:date],distance: params[:run][:distance],duration: params[:run][:duration])
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
    @run = Run.find_by(params[:id])
    erb :"/runs/show.html"
  end


 #UPDATE

  get "/runs/:id/edit" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @run = Run.find_by(params[:id])
    erb :"/runs/edit.html"
  end

  post "/runs/:id" do
    redirect_if_not_logged_in
    run = Run.find_by(params[:id])
    run.update(date: params["date"], distance: params["distance"], duration: params["duration"])
    redirect "/runs/#{params[:id]}"
  end

  patch " " do
    
  end

  #DELETE:

  delete "/runs/:id" do
    @run = Run.find_by(params[:id])
    @run.destroy
    redirect "/runs"
  end
end
