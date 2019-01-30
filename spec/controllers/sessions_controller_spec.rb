require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "should redirect to home page if user is already logged in" do
      session[:user_id] = 1
      get :new
      response.should redirect_to(root_path)
    end
  end
end
