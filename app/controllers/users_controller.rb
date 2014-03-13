class UsersController < ApplicationController
  before_action :authenticate_user!

  def index 
    @users = User.all
  end
 
  def new
    @user = User.new
  end
 
  def create
    @user = User.new(params[:user])
    #@user[:expiration_at] = 180.days.ago
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path }
      else
        format.html { render new_users_path }
      end
    end
  end
end
