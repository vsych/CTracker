require 'spec_helper'

describe Currency do
  subject{ currencies(:one) }

  it { should be_valid }

  describe "validation" do
    subject{ Currency.new }

    before(:each) do
      subject.valid?
    end

    it "should validate presence of name" do
      subject.errors[:name].should include("can't be blank")
    end

    it "should validate presence of code" do
      subject.errors[:code].should include("can't be blank")
    end

    it "should validate uniqueness of code" do
      existed = currencies(:one)
      new_currency = Currency.new(:name => existed.name, :code => existed.code)
      new_currency.valid?.should be_false
      new_currency.errors[:code].should include("has already been taken")
    end
  end
end
