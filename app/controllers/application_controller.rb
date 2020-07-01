class ApplicationController < ActionController::Base
  before_action :basic
  protect_from_forgery with: :exception
  include SessionsHelper

  def authenticate_user
    unless logged_in?
      flash[:success] = 'ログインしてください'
      redirect_to new_session_path
    end
  end  
  private
  def basic
    if Rails.env.production?
      authenticate_or_request_with_http_basic do |name, password|
        name == ENV['USERNAME'] && password == ENV['PASSWORD']
      end
    end
  end
end
