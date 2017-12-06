class MembersController < ApplicationController
    def index
      @members=Member.all
    end
    def new
      @members= Member.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @members }
      end
    end
    def create
      @members = Member.new(member_params)
      @cars = Car.all
      respond_to do |format|
        if @members.save
          log_in @members
          flash[:success] = "Welcome to the Sample App!"
          format.html { redirect_to :controller => 'cars', :action => 'index', notice: 'Member was successfully created.' }
          format.json { render json: @cars, status: :created, location: @cars }
        else
          format.html { render action: "new" }
          format.json { render json: @members.errors, status: :unprocessable_entity }
        end
      end
    end
    def createad
      @members = Member.new
      @members.name = params[:name]
      @members.email = params[:email]
      @members.password = params[:password]
      @members.state = "admin"
      @cars = Car.all
      respond_to do |format|
        if @members.save
          flash[:success] = "Admin Added Successfully"
          format.html { redirect_to :controller => 'cars', :action => 'index', notice: 'Admin was successfully created.' }
          format.json { render json: @cars, status: :created, location: @cars }
        else
          format.html { render action: "new" }
          format.json { render json: @members.errors, status: :unprocessable_entity }
        end
      end
    end
    def createsys
      @members = Member.new
      @members.name = params[:name]
      @members.email = params[:email]
      @members.password = params[:password]
      @members.state = "sysadmin"
      @cars = Car.all
      respond_to do |format|
        if @members.save
          flash[:success] = "Super Admin Added Successfully"
          format.html { redirect_to :controller => 'cars', :action => 'index', notice: 'Super Admin was successfully created.' }
          format.json { render json: @cars, status: :created, location: @cars }
        else
          format.html { render action: "new" }
          format.json { render json: @members.errors, status: :unprocessable_entity }
        end
      end
    end
    def show
      @members = Member.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @members }
      end
    end
    def edit
      @members = Member.find(params[:id])
    end

    def update
      @members = Member.find(params[:id])

      respond_to do |format|
        if @members.update_attributes(member_params)
          format.html { redirect_to @members, notice: 'Member was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @members.errors, status: :unprocessable_entity }
        end
      end
    end
    def destroy
      @members=Member.find(params[:id])
      @history=History.find_by_email_and_status(@members.email,"checkedout")
      if(!@history.nil?)
          flash[:notice] = "User has a checkout car. So cannot delete him/her"
      else
        @history= History.where(:email=>@members.email,:status=>"Reserved").destroy_all
        flash[:notice] = "Removed all reserved cars for this user"
        @members.destroy
        flash[:success] = "Member deleted"
      end
      redirect_to members_url
    end

    def new_sys
      render template: 'members/new_sys'
    end

    private
    def set_member
      @members=Member.find(param[:id])
    end
    def member_params
      params.require(:member).permit(:name, :email, :password)
    end
end