class Admin::UsersController < ApplicationController

  before_filter :authorized?
  
  def index
    @users = User.all.page(params[:page]).per(2)
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

    if @user.save
      redirect_to admin_user_path, notice: "#{@user.full_name} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_user_path
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end

  def authorized?
    if current_user
      unless current_user.admin == true
        flash[:accessdenied] = "Must be an admin"
        redirect_to root_path
      end
    else
      flash[:accessdenied] = "Please log in"
      redirect_to root_path
    end
  end

end
