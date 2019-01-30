require 'spec_helper'

describe User do
  subject{ users(:one) }

  let(:first_country){ countries(:one) }
  let(:second_country){ countries(:two) }
  let(:third_country){ countries(:three) }
  let(:first_currency){ currencies(:one) }
  let(:second_currency){ currencies(:two) }
  let(:third_currency){ currencies(:three) }
  let(:fourth_currency){ currencies(:four) }

  it { should be_valid }

  it "should has many collected currencies" do
    subject.currencies.should be_kind_of(Array)
  end

  it "should has many visited countries" do
    subject.countries.should be_kind_of(Array)
  end

  # TODO improve
  it "should encrypt password" do
    user = User.new(:email => "three@example.com", :password => "Password123!")
    user.save

    user.persisted?.should be_true
    user.password.should_not eq(user.encrypted_password)
    user.reload.password.should be_empty
    user.encrypted_password.should_not be_empty
  end

  context "validation" do
    subject{ User.new }

    before(:each) do
      subject.valid?
    end

    it "should validate presence of email" do
      subject.errors[:email].should include("can't be blank")
    end

    it "should validate uniqueness of email" do
      existed_user = users(:one)
      user = User.new(:email => existed_user.email)
      user.valid?.should be_false
      user.errors[:email].should include("has already been taken")
    end

    it "should not allow password shorten when 5 symbols" do
      u = User.new(:password => "1234")
      u.valid?.should be_false
      u.errors[:password].should include("is too short (minimum is 5 characters)")
    end

    it "should validate password for new record" do
      subject.errors[:password].should include("can't be blank", "is too short (minimum is 5 characters)")
    end
  end

  describe "#toggle_visiting" do
    it "should remember that user has visited this country if he wasn't" do
      expect{
        subject.toggle_visiting(third_country)
      }.to change{subject.countries.count}.by(1)
    end

    it "should set country unvisited if he was" do
      subject.toggle_visiting(third_country)
      expect{
        subject.toggle_visiting(third_country)
      }.to change{subject.countries.count}.by(-1)
    end

    it "should collect all currencies whilst you are in the country" do
      expect{
        subject.toggle_visiting(third_country)
      }.to change{subject.currencies.count}.by(2)
    end

    it "remove currencies from collection if country was mark as visited by mistake" do
      expect{
        subject.toggle_visiting(first_country)
      }.to change{subject.currencies.count}.by(-2)
    end
  end

  describe "#visited?" do
    it "should return true if user has visited particular country" do
      subject.visited?(first_country).should be_true
    end

    it "should return false if user has not visited particular country" do
      subject.toggle_visiting(first_country)
      subject.visited?(first_country).should be_false
    end
  end

  describe "#update_collection" do
    it "should add currency to collection if user has no one" do
      expect{
        subject.update_collection(third_currency)
      }.to change{subject.currencies.count}.by(1)
    end

    it "should remove from collection if user has one in it" do
      subject.update_collection(third_currency)
      expect{
        subject.update_collection(third_currency)
      }.to change{subject.currencies.count}.by(-1)
    end

    context "making assumption that we collect only when visiting" do
      it "country should be marked as visited on collection updating" do
        expect{
          subject.update_collection(third_currency)
        }.to change{subject.countries.count}.by(1)
      end
    end

    it "should mark country as not visited if no collected currency ramains" do
      subject.toggle_visiting(third_country)
      subject.update_collection(third_currency)
      expect{
        subject.update_collection(fourth_currency)
      }.to change{subject.countries.count}.by(-1)
    end
  end

  describe "#collected?" do
    it "should indicate has user currency in collection or not" do
      subject.update_collection(third_currency)
      subject.collect?(third_currency).should be_true
      subject.collect?(fourth_currency).should be_false
    end
  end
end
