require 'time'
require 'date'
class HistoriesController < ApplicationController
  def history_params
    params.require(:history).permit(:lic, :from, :to, :email, :status)
  end
  def index
    @histories = History.where(email: params[:email])
    @members=Member.where(id: params[:tempuser])
  end
  def carhistory
    @histories = History.where(lic: params[:car_lic])
    respond_to do |format|
      format.html { render :template => "histories/carhistory" }
    end
  end
  def edit
    @histories = History.find(params[:id])
  end
  def update

    @histories = History.find(params[:id])
    @histories.update_attributes(history_params)
    @histories.status = "Available"
    @cars = Car.find_by_lic(@histories.lic)
    f= @histories.from
    t= @histories.to
    if(t<f)
      redirect_to cars_url, notice: 'From Date Cannot be beyond To Date, Please Try again'
      return
    end
    if(Time.now>f)
      redirect_to cars_url, notice: 'You cannot book for a passed Time/Date'
      return
    end
    if(t>Time.now+7*24*60*60)
      redirect_to cars_url, notice: 'We are really sorry, Booking beyond 7 days are not allowed'
      return
    end
    @hist=History.where(:lic=>@histories.lic,:status=>"Reserved")
    @hist.each do |h|
      k=h.from
      l=h.to
      if (k<f and f<l) || (k<t and t<l) || (f<k and l<t)
        redirect_to cars_url, notice: 'We are really sorry, Car is already resreved for that duration'
        return
      end
    end
    @hist=History.where(:lic=>@cars.lic,:status=>"checkedout")
    @hist.each do |h|
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
    @histories.status ="Reserved"
    @histories.amount = ((t-f)/3600 * @cars.rate).round(2)



    respond_to do |format|
      if @histories.save
        format.html { redirect_to cars_path, notice: 'Reservation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @histories.errors, status: :unprocessable_entity }
      end
    end
  end
 end