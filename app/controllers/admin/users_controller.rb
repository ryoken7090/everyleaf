class Admin::UsersController < ApplicationController
  before_action :authenticate_user
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_only
  def index
    @users = User.includes(:tasks).all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    end
  end

  def show
    @tasks = @user.tasks.page(params[:page]).per(10)
  end

  def edit
  end

  def update
    # binding.pry
    if @user.update(user_params)
      redirect_to admin_users_path, notice: '更新しました'
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: 'ユーザーを削除しました'
    else
      redirect_to admin_users_path, notice: '少なくとも1つ、管理者アカウントが必要です'
    end
    
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end
