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
    @run = Run.find(params[:id])
    erb :"/runs/show.html"
  end


 #UPDATE

  get "/runs/:id/edit" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @run = Run.find(params[:id])
    erb :"/runs/edit.html"
  end

  
  # patch "/runs/:id" do
  #   @run = Run.find(params[:id])
  #   @run.update(params.select{|k|k=="date" || k=="distance" || k=="duration"})
  #   redirect "/runs/:id"
  # end

  post "/runs/:id" do
    redirect_if_not_logged_in
    @run = Run.find(params[:id])
    @run.update(date: params["date"], distance: params["distance"], duration: params["duration"])
    redirect "/runs/#{@run.id}"
    # unless Run.valid_params?(params)
    #   redirect "/runs/#{@run.id}/edit?error=invalid run"
    # end
    # @run.update(params.select{|k|k=="date" || k=="distance" || k=="duration"})
    # redirect "/runs/#{@run.id}"
  end

  # DELETE: /runs/5/delete
  delete "/runs/:id/delete" do
    redirect_if_not_logged_in
    id = params[:id]
    Run.destroy(id)
    redirect "/runs"
  end
end
