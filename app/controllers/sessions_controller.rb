class SessionsController < ApplicationController

before_filter :bla

def bla
  binding.pry
end


  
  def new
  end

  def create
  	user = User.where("LOWER(name) = LOWER(?)", params[:session][:name_or_email].downcase).first
    user ||= User.where("LOWER(email) = LOWER(?)", params[:session][:name_or_email].downcase).first
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash[:error] = 'Please enter a valid username or email'
      redirect_to root_path
    end
  end

  def destroy
  	sign_out
  	redirect_to root_path
  end

end