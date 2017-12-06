class SessionsController < ApplicationController

  def new
  end

  def new_admin
    render :template => "sessions/new_admin"
  end

  def create
    user = Member.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.state=="admin"
        flash[:notice] = "Please login as admin"
        redirect_to root_url
       else
        log_in user
        redirect_to :controller => 'cars', :action => 'index'
      end
    else
      flash.now[:notice] = "Invalid email/password combination"
      render 'new'
    end
  end
  def createadmin
    user = Member.find_by(email: params[:session][:email].downcase)
    if  user.nil? || (user.state=="admin")
      if user && user.authenticate(params[:session][:password])
        log_in user
        is_admin?
        redirect_to :controller => 'cars', :action => 'index'
      else
        flash.now[:notice] = 'Invalid email/password combination'
        render 'new_admin'
      end
    elsif  user.nil? || user.state=="sysadmin"
        if user && user.authenticate(params[:session][:password])
          log_in user
          is_sysadmin?
          redirect_to :controller => 'cars', :action => 'index'
        else
          flash.now[:notice] = 'Invalid email/password combination'
          render 'new_admin'
        end
    else
        flash[:notice] = "You are not an admin or sysadmin"
        redirect_to root_url
    end
  end
  def destroy
    log_out
    redirect_to root_url
  end
end

