class SessionsController < ApplicationController
  before_filter :signed_in_user, only: :destroy
  

  def new
    render :layout => 'landing'
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash[:error] = 'Invalid email/password combination. Email info@makersmoon.com for help if you need it!'
      render :action =>'new', :layout => 'landing'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end