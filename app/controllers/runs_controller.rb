class RunsController < ApplicationController

  before ("/runs") do
    redirect_if_not_logged_in if request.path_info != "/login"
  end

  #CREATE

  get '/runs' do
    if logged_in?
      @user = current_user
      @runs = current_user.runs 
      erb:"runs/index.html"
    else
      redirect "/login"
    end
  end

  get '/runs/new' do
    if logged_in?
      erb :'/runs/new'
    else
      redirect "/login"
    end
  end

  post '/runs' do
    @s = current_user.runs.build(params)
    if @s.save
      redirect "/runs"
    else
      erb :"runs/new.html"
    end
  end

  get '/runs/:id/edit' do
    if logged_in?
      @run = Run.find_by_id(params[:id])
      if @run.user_id == current_user.id
        erb :'runs/edit.html'
      else
        redirect "/runs"
      end
    end
  end

  patch "/runs/:id" do
    redirect_if_not_authorized

    @run = Run.find(params[:id])
    unless Run.valid_params?(params)
      redirect "/runs/#{@run.id}/edit?error=invalid run"
    end
    @run.update(params.select{|k|k=="distance" || k=="duration" || k=="date"})
    redirect "/runs/#{@run.id}"
  end

  get '/runs/:id' do
    @run = Run.find_by(id: params[:id])
    if logged_in?
      erb :"/runs/show"
    else
      redirect "/login"
    end
  end 

  delete '/runs/:id' do
    @run = Run.find(params[:id])
    if logged_in? && @run.user_id == current_user.id
      @run.destroy
      redirect "/runs"
    else
      redirect "/login"
    end
  end

end
