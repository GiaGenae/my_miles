class RunsController < ApplicationController

  # GET: /runs
  get "/runs" do
    erb :"/runs/index.html"
  end

  # GET: /runs/new
  get "/runs/new" do
    erb :"/runs/new.html"
  end

  # POST: /runs
  post "/runs" do
    redirect "/runs"
  end

  # GET: /runs/5
  get "/runs/:id" do
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
