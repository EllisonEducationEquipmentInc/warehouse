class AdminsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @users = User.page params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to admins_path, notice: 'User has been created'
    else
      render :new
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def show
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      redirect_to admins_path, notice: 'User has been updated'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    redirect_to admins_path, alert: 'User has been destroyed'
  end



private
  def user_params
    params.require(:user).permit!
  end
end

