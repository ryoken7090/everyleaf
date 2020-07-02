class UsersController < ApplicationController
  def new
    @user = User.new
    if current_user
      redirect_to tasks_path, notice: 'ログイン状態で遷移できないページです'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice: '登録が完了しました'
    else
      render :new
    end
  end
  def show
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to tasks_path, notice: '
    他ユーザーのページには遷移できません'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
