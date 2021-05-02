class SessionsController < ApplicationController

  # GET: /sessions
  get "/login" do
    erb :"/sessions/login.html"
  end


  # POST: /sessions
  post "/login" do
    binding.pry
  end

  get "/logout" do
    session.clear
    redirect "/"
  end
end
