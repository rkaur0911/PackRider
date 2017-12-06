desc "Updates a Reservation which is not checked out"
task uncommited_reservations: :environment do
  @histories=History.where(:status=>"Reserved")
  @histories.each do |h|
    if h.from+30*60<Time.now
      h.status="Avialable"
      h.save
    end
  end
end

desc "Return checkout if car checkout time ended"
task unreturned_checkout: :environment do
  @histories=History.where(:status=>"checkedout")
  @histories.each do |h|
    if h.to<Time.now
      h.status="Avialable"
      h.save
      @cars = Car.find_by_lic(h.lic)
      @cars.status = "Available"
      @cars.save!
      @notifications=Notification.where(lic: h.lic)
      @notifications.each do |notification|
        UserMailer.car_avialablility(notification).deliver
      end
      @notifications.destroy_all
      UserMailer.checkout_notification(h).deliver
    end
  end
end