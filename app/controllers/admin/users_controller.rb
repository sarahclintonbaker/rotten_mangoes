class Admin::UsersController < ApplicationController

  before_filter :authorized?
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
  end

  protected

  def authorized?
    unless current_user.admin == true
      flash[:error] = "Must be an admin"
      redirect_to root_path
    end
  end

end
