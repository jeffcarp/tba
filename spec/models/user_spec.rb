require 'spec_helper'

describe User do

  before { @user = User.new(:name => "Groucho Marx", :email => "gccarpen@colby.edu") }
  
  subject { @user }
  
  it { should respond_to :name }
  it { should respond_to :email }

  it { should be_valid }
  
  describe "when name is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

end