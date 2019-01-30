require "spec_helper"

describe CurrenciesController do
  include_context "logged in user"
  let(:country){ countries(:three) }
  let(:first_currency){ country.currencies.first }

  describe "GET index" do
    it "should be success" do
      get :index
      response.should be_success
    end
  end

  describe "GET show" do
    it "should be success" do
      get :show, :id => country.code
      response.should be_success
    end
  end

  describe "GET collect" do
    context "html" do
      it "should set currency as collected if it wasn't" do
        get :collect, :id => first_currency, :format => :html
        response.should redirect_to(currencies_path)
        flash[:notice].should include("Currency was successfully as collected")
      end

      it "should makr currency as not collected if it was" do
        user.update_collection(first_currency)
        get :collect, :id => first_currency, :format => :html
        response.should redirect_to(currencies_path)
        flash[:notice].should include("Currency was successfully as not collected")
      end
    end

    context "json" do
      it "should set currency as collected if it was not" do
        get :collect, :id => first_currency, :format => :json
        json = ActiveSupport::JSON.decode(response.body)
        json["message"].should eq("Currency was successfully as collected")
        json["status"].should eq("Collected")
        json["Collected"].should eq(user.currencies.count)
        json["Not Collected"].should eq(Currency.count - user.currencies.count)
      end

      it "should set currency as not collecte" do
        user.update_collection(first_currency)
        get :collect, :id => first_currency, :format => :json
        json = ActiveSupport::JSON.decode(response.body)
        json["message"].should eq("Currency was successfully as not collected")
        json["status"].should eq("Not Collected")
        json["Collected"].should eq(user.currencies.count)
        json["Not Collected"].should eq(Currency.count - user.currencies.count)
      end
    end
  end

  context "GET statistic" do
    before(:each) do
      user.toggle_visiting(country)
    end

    it "should collect statistic of countries visiting" do
      get :statistic, :format => :json
      json = ActiveSupport::JSON.decode(response.body)
      json["collection"].count.should eq(2)
      json["collection"][0]["cnt"].should eq(2)
      json["collection"][1]["cnt"].should eq(2)
    end
  end

end
