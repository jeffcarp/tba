require 'spec_helper'

describe User do

  context "should have attributes" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      subject { @user }
    end

    it { should respond_to :name }
    it { should respond_to :email }
    it { should respond_to :canpost }
    it { should respond_to :admin }
    it { should respond_to :uid }
    it { should respond_to :provider }
  end

end

# describe "create_with_omniauth" do
#   before(:each) do
#     @user = FactoryGirl.create(:user)

#     # Mimic Google's Oauth2 callback hash
#     auth = Hash.new
#     auth["info"] = Hash.new
#     auth["info"]["name"] = @user.name
#     auth["info"]["email"] = @user.email
#     auth["uid"] = @user.uid
#     auth["provider"] = @user.provider
#   end

#   it "should create a valid user from an omniauth callback" do

#     user = User.create_with_omniauth(auth)
#     subject { user }
#     it { should be_valid }
#   end

# end