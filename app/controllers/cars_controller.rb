require 'time'
require 'date'
class CarsController < ApplicationController
  def car_params
    params.require(:car).permit(:lic, :manf, :mod, :style, :location, :rate, :status)
  end
  def index
    @cars = Car.all
  end
  def new
    @cars = Car.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end
  def create
    @cars = Car.new(car_params)

    respond_to do |format|
      if @cars.save
        format.html { redirect_to @cars, notice: 'car was successfully created.' }
        format.json { render json: @cars, status: :created, location: @cars }
      else
        format.html { render action: "new" }
        format.json { render json: @cars.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @cars = Car.find(params[:id])
    @recenthistory=History.find_by_lic_and_status(@cars.lic,"checkedout")
    if @recenthistory.nil?
      @recenthistory=History.find_by_lic_and_status(@cars.lic,"Reserved")
    end
    session[:car_id]= @cars.id
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cars }
    end
  end

  def edit
    @cars = Car.find(params[:id])
  end

  def update
    @cars = Car.find(params[:id])

    respond_to do |format|
      if @cars.update_attributes(car_params)
        format.html { redirect_to @cars, notice: 'Car was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cars.errors, status: :unprocessable_entity }
      end
    end
  end

  def returncar
    @cars = Car.find_by_lic(params[:history_lic])
    @cars.status = "Available"
    @cars.save!
    @notifications=Notification.where(lic: params[:history_lic])
    @notifications.each do |notification|
      UserMailer.car_avialablility(notification).deliver
    end
    @notifications.destroy_all
    UserMailer.car_avialablility(@cars).deliver
    @history= History.find(params[:history_id])
    @history.status = "Available"
    @history.to = Time.now
    @history.amount =((@history.to - @history.from)/3600 * @cars.rate).round(2)
    @history.save
    redirect_to histories_path(:email=> @history.email),method: :get, notice: "Car is Returned, Please check your final payable amount"
  end

  def destroy
    @cars = Car.find(params[:id])
    if @cars.status=="checkedout"
      respond_to do |format|
        format.html { redirect_to cars_url, notice: 'Car cannot be deleted because it is presently checkedout by user' }
        format.json { head :no_content }
      end
    elsif
      @cars.destroy
      @history= History.where(:lic=>@cars.lic,:status=>"Reserved").destroy_all
      flash[:notice] = "Deleted all reservations this car has from history."
      respond_to do |format|
        format.html { redirect_to cars_url }
        format.json { head :no_content }
      end
    end
  end

  def search
    @entry = Car.where(manf: params[:item]) + Car.where(location: params[:item]) + Car.where(rate: params[:item]) + Car.where(mod: params[:item]) + Car.where(style: params[:item]) + Car.where(status: params[:item])
    @entry = @entry.uniq
  end

  def checkout
    if params.has_key?(:car_id)
    @cars = Car.find(params[:car_id])
    session[:car_id]= @cars.id
    respond_to do |format|
      format.html { render :template => "cars/checkout" }
    end
    else
      @cars = Car.find_by_lic(params[:car_lic])
      @cars.status="checkedout"
      @cars.save
      if session[:is_admin?]
        @email=params[:email]
      else
        @email=session[:email]
      end
      @history=History.find_by_email_and_status(@email, "Reserved")
      @history.status="checkedout"
      @history.save
      redirect_to histories_path(:email=> @email),method: :get, notice: "Car is successfully checked out"
    end
  end

  def checkoutsubmit
    @cars=Car.find(session[:car_id])
    if session[:is_admin?]
      @email=params[:email]
    else
      @email=session[:email]
    end

    if History.find_by_email_and_status(@email, "Reserved").nil? && History.find_by_email_and_status(@email, "checkedout").nil?
      f= Time.now
      t= params[:datetime2].to_time
      @histories=History.where(:lic=>@cars.lic,:status=>"Reserved")
      @histories.each do |h|
        k=h.from
        l=h.to
        if (k<f and f<l) || (k<t and t<l) || (f<k and l<t)
          redirect_to cars_url, notice: 'We are really sorry, Car is already resreved for that duration'
          return
        end
      end

      if (t-f)/60 < 60
        redirect_to cars_url, notice: 'We are really sorry, Booking has to be made atleast for 1hr'
        return
      end
      if (t-f)/60 > 600
        redirect_to cars_url, notice: 'We are really sorry, you can only book for upto 10hours'
        return
      end
        @cars.status = "checkedout"
      @cars.save!
      @history=History.new
      @history.lic=@cars.lic
      @history.status="checkedout"
      @history.email=@email
      @history.from=Time.now
      @history.to=params[:datetime2].to_time
      @history.amount = ((t-f)/3600 * @cars.rate).round(2)
      respond_to do |format|
        if @history.save
          format.html { redirect_to @cars, notice: 'car was successfully checked out.' }
          format.json { render json: @cars, status: :created, location: @cars }
        end
      end
    else
      redirect_to @cars, notice: 'You already have a reservation or checkedout car!'
    end
  end
  def reserve
    @cars = Car.find(params[:car_id])
    session[:car_id]= @cars.id
    respond_to do |format|
      format.html { render :template => "cars/reserve" }
    end
  end
  helper_method :reserve

  def reservesubmit
    @cars=Car.find(session[:car_id])
    if session[:is_admin?]
      @email=params[:email]
      if Member.find_by_email(@email).nil?
        redirect_to cars_url, notice: 'The user mentioned has not signed up yet'
        return
      end
    else
      @email=session[:email]
    end
    if History.find_by_email_and_status(@email, "Reserved").nil? && History.find_by_email_and_status(@email, "checkedout").nil?
      f= params[:datetime1].to_time
      t= params[:datetime2].to_time
      @histories=History.where(:lic=>@cars.lic,:status=>"Reserved")
        @histories.each do |h|
        k=h.from
        l=h.to
        if (k<f and f<l) || (k<t and t<l) || (f<k and l<t)
          redirect_to cars_url, notice: 'We are really sorry, Car is already resreved for that duration'
          return
        end
        end
      @histories=History.where(:lic=>@cars.lic,:status=>"checkedout")
      @histories.each do |h|
        k=h.from
        l=h.to
        if (k<f and f<l) || (k<t and t<l) || (f<k and l<t)
          redirect_to cars_url, notice: 'We are really sorry, Car is already checkedout for that duration'
          return
        end
      end


      if (t-f)/60 < 60
        redirect_to cars_url, notice: 'We are really sorry, Booking has to be made at least for 1 hour'
        return
      end
      if (t-f)/60 > 600
            redirect_to cars_url, notice: 'We are really sorry, you can only book for upto 10hours'
          return
            end
      @history=History.new
    @history.lic=@cars.lic
    @history.status="Reserved"
    @history.email=@email
    @history.from=params[:datetime1].to_time
    @history.to=params[:datetime2].to_time
      @history.amount = ((t-f)/3600 * @cars.rate).round(2)
    respond_to do |format|
      if @history.save
        format.html { redirect_to @cars, notice: 'Car was successfully reserved.' }
        format.json { render json: @cars, status: :created, location: @cars }
      end
    end
    else
      redirect_to @cars, notice: 'You already have a reservation or checkedout car!'
    end
  end
end