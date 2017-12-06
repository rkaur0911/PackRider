class SuggestionsController < ApplicationController
  def index
    @suggestions = Suggestion.where(active: true)
  end
  def show
    @suggestion = Suggestion.find(params[:id])
    if @suggestion
      render 'show'
    else
      flash[:notice] = "Page not Found!"
      redirect_to cars_url
    end
  end
  def new
    @suggestion = Suggestion.new
    @suggestion.email = session[:user_id]
  end
  def create
    @suggestion = Suggestion.new(suggestion_params)
    @suggestion.email = session[:email]
    if @suggestion.save
      redirect_to @suggestion
    else
      render 'new'
    end
  end
  def edit
    @suggestion = Suggestion.find(params[:id])
  end
  def update
    @suggestion = Suggestion.find(params[:id])
    @suggestion.update_attributes(suggestion_params)
      @cars = Car.new
      @cars.lic = @suggestion.lic
      @cars.manf = @suggestion.manf
      @cars.mod = @suggestion.mod
      @cars.style = @suggestion.style
      @cars.rate=@suggestion.rate
      @cars.location=@suggestion.location
      @cars.status="Available"
      @suggestion.update_attribute(:active,false)
      respond_to do |format|
      if @cars.save!
        format.html { redirect_to @cars, notice: 'Suggestion Approved' }
        format.json { render json: @cars, status: :created, location: @cars }
       else
         format.html { render action: "edit" }
         format.json { render json: @suggestions.errors, status: :unprocessable_entity }
       end
      end
    end
  def destroy
    @suggestion = Suggestion.find(params[:id])
    #   @suggestion.update_attribute(:active,false)
    @suggestion.active = false
    if @suggestion.save
      redirect_to suggestions_url
    else
      render 'index'
    end
  end

  private
  def suggestion_params
    params.require(:suggestion).permit(:email,:lic,:manf,:mod,:style,:rate,:location,:status)
  end
end