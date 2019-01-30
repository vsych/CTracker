require 'spec_helper'

describe UserCountry do
  let(:user){ users(:one) }
  let(:currency){ country(:one)}
  subject{ user_countries(:one) }

  it { should be_valid }

  context "validation" do
    it "should belong to user" do
      subject.user.should be_kind_of(User)
    end

    it "should belong to currency" do
      subject.user.should be_kind_of(User)
    end

    it "should validate presence of user" do
      uc = UserCountry.new
      uc.valid?
      uc.errors[:user].should include("can't be blank")
    end

    it "should validate presence of currency" do
      uc = UserCountry.new
      uc.valid?
      uc.errors[:country].should include("can't be blank")
    end
  end

  describe ".user_statistic" do
    it "should select count of visited countries per day" do
      uc = UserCountry.user_statistic(user)
      uc.first.cnt.should eq(2)
      uc.first.date.should be_present
    end
  end
end
