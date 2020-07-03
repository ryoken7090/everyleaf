class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to tasks_path, notice: 'ログイン中には遷移できません'
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      render :new, notice: 'ログインできませんでした'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path
  end
end
