class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # 管理者画面のユーザー一覧画面に遷移
      redirect_to admin_users_path
    end
  end

  def show
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

  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end
