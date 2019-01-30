require 'spec_helper'

describe UserCurrency do
  let(:user){ users(:one) }
  let(:currency){ currencies(:one)}
  let(:country){ countries(:three) }
  subject{ user_currencies(:one) }

  it { should be_valid }

  context "validation" do
    it "should belong to user" do
      subject.user.should be_kind_of(User)
    end

    it "should belong to currency" do
      subject.user.should be_kind_of(User)
    end

    it "should validate presence of user" do
      uc = UserCurrency.new
      uc.valid?
      uc.errors[:user].should include("can't be blank")
    end

    it "should validate presence of currency" do
      uc = UserCurrency.new
      uc.valid?
      uc.errors[:currency].should include("can't be blank")
    end
  end

  describe ".user_statistic" do
    it "should select count of collected currencies per day" do
      user.toggle_visiting(country)
      uc = UserCurrency.user_statistic(user)
      uc.all.count.should eq(2)
      uc.first.cnt.should eq(2)
      uc.last.cnt.should eq(2)
      uc.first.date.should be_present
    end
  end
end
