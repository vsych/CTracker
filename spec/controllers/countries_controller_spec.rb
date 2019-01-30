require "spec_helper"

describe CountriesController do
  include_context "logged in user"

  let(:country){ countries(:three) }

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

  describe "GET visit" do
    context "html" do
      it "should remeber that user has visited that country" do
        get :visit, :id => country.code, :format => :html
        response.should redirect_to(countries_path)
        flash[:notice].should include("Country was successfully marked as visited")
      end

      it "should mark country as unvisited if it was so" do
        user.toggle_visiting(country)
        get :visit, :id => country.code, :format => :html
        flash[:notice].should include("Country was successfully marked as not visited")
      end
    end

    context "json" do
      it "should remeber that user has visited that country" do
        get :visit, :id => country.code, :format => :json
        json = ActiveSupport::JSON.decode(response.body)
        json["message"].should eq("Country was successfully marked as visited")
        json["status"].should eq("Visited")
        json["Visited"].should eq(user.countries.count)
        json["Not Visited"].should eq(Country.count - user.countries.count)
      end

      it "should mark country as unvisited if it was so" do
        user.toggle_visiting(country)
        get :visit, :id => country.code, :format => :json
        json = ActiveSupport::JSON.decode(response.body)
        json["message"].should eq("Country was successfully marked as not visited")
        json["status"].should eq("Not Visited")
        json["Visited"].should eq(user.countries.count)
        json["Not Visited"].should eq(Country.count - user.countries.count)
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
      json["collection"].should be_kind_of(Array)
      json["collection"][0]["cnt"].should eq(3)
    end
  end

end
