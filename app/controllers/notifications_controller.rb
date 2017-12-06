class NotificationsController < ApplicationController
  def createnotify
    @notifications=Notification.find_by_lic_and_email(params[:car_lic],session[:email])
    if !@notifications.nil?
      redirect_to cars_path, notice: 'You are already registered for notifications'
    else
    @notifications = Notification.new
    @notifications.email=session[:email]
    @notifications.lic=params[:car_lic]
    respond_to do |format|
      if @notifications.save
        format.html { redirect_to cars_path, notice: 'User will be notified if car is avialable' }
        format.json { render json: cars_path, status: :created, location: @cars }
      else
        redirect_to cars_path, notice: 'Sorry failed to update notification in DB'
      end
    end
      end
  end
end