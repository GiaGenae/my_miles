class RunsController < ApplicationController

  # before ("/runs") do
  #   redirect_if_not_logged_in if request.path_info != "/login"
  # end

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
      erb :'/runs/new.html'
    else
      redirect "/login"
    end
  end

  post '/runs' do
    run = current_user.runs.create(date: params[:run][:date],distance: params[:run][:distance],duration: params[:run][:duration])
    if run.valid?
      redirect "/runs"
    else
      flash[:error] = run.errors.full_messages.join(", ")
      redirect "/runs/new"
    end
  end

  get '/runs/:id' do
    @run = Run.find_by(id: params[:id])
    if logged_in?
      erb :"/runs/show.html"
    else
      redirect "/login"
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
    @run.update(params.select{|k|k=="date" || k=="distance" || k=="duration"})
    redirect "/runs/index.html"
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
