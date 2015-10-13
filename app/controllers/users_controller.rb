class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit,  :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "update user infomation successful!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Deleted succesful!"
    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_user
      if !logged_in?
        flash[:danger] = "Please log in!"
        redirect_to login_path
      end
    end

    def correct_user
      @user = User.find(params[:id])
      if @user != current_user
        redirect_to root_path
      end
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
