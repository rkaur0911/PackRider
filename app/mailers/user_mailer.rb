class UserMailer < ApplicationMailer
  def car_avialablility(notification)
    @notifications = notification
    @url  = # generate confirmation url
        mail(to: notification[:email], subject: "Car is avialable")
  end
  def checkout_notification(history)
    @histories = history
    @url  = # generate confirmation url
        mail(to: history[:email], subject: "Car is made avialable")
  end
end
