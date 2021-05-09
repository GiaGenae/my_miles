class RunsController < ApplicationController

  before ("/runs") do
    redirect_if_not_logged_in if request.path_info != "/login"
  end

  #CREATE

  get "/runs" do
    redirect_if_not_logged_in
    if logged_in?
      @user = current_user
      @runs = current_user.runs
      erb :"/runs/index.html"
    else
      redirect "/login"
    end
  end

  get "/runs/new" do
    redirect_if_not_logged_in
    erb :"/runs/new.html"
  end

  post "/runs" do
    @s = current_user.runs.build(params)
    if @s.save
      redirect "/runs/index.html"
    else
      erb :"/runs/new.html"
    end
  end

  #READ

  get "/runs/:id" do
    redirect_if_not_logged_in
    get_run
    erb :"/runs/show.html"
  end


 #UPDATE

  get "/runs/:id/edit" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    get_run
    erb :"/runs/edit.html"
  end

  patch "/runs/:id" do
    redirect_if_not_logged_in
    get_run
    unless Run.valid_params?(params)
      redirect "/runs/#{@run.id}/edit?error=invalid run"
    end
    @run.update(params.select{|k|k=="date" || k=="distance"} || k=="date")
    redirect "/runs/#{@run.id}"
  end

  #DELETE:

  delete "/runs/:id" do
    get_run
    @run.destroy
    redirect "/runs"
  end
end
