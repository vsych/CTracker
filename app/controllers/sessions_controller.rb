class SessionsController < ApplicationController

  skip_before_filter :authenticate
  before_filter :redirect_if_user_logged_in

  def new
    @session = Session.new
  end

  def create
    @session = Session.new(params[:session])
    respond_to do |format|
      if @session.valid?
        session[:user_id] = @session.user.id
        format.html{ redirect_to root_path, :flash => {:success => "You successfully logged in"}}
      else
        format.html{ render :new }
      end
    end
  end

  def destroy

  end

  private

  def redirect_if_user_logged_in
    redirect_to root_path if user_logged_in?
  end

end
