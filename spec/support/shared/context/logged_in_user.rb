shared_context "logged in user" do
  let(:user){ users(:one) }
  before(:each) do
    session[:user_id] = user.id
  end
end
