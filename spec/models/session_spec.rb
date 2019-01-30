require 'spec_helper'

describe Session do
  let(:user){ users(:one) }
  let(:valid_password){ "Password123!" }

  describe ".valid_credentials?" do
    it "should recognize user with valid email and password" do
      session = Session.new({:email => user.email, :password => valid_password})
      session.valid?.should be_true
    end

    it "should recognize user with not valid credentials" do
      session = Session.new({:email => user.email, :password => "Wrong Password"})
      session.valid?.should be_false
    end
  end

  describe "#user" do
    it "should containt user if such exists in database" do
      session = Session.new({:email => user.email, :password => valid_password})
      session.user.should be_kind_of(User)
    end

    it "should point to nil if no such user" do
      session = Session.new({:email => "some@not-existing.user", :password => valid_password})
      session.user.should be_nil
    end
  end
end
