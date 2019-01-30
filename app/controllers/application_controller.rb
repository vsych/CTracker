class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :user_logged_in?
  helper_method :current_user

  before_filter :authenticate

  private

  def current_user
    User.find(session[:user_id])
  end

  def authenticate
    redirect_to new_session_path unless user_logged_in?
  end

  def user_logged_in?
    session.has_key?(:user_id)
  end
end
