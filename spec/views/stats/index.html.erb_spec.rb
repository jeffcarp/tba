require 'spec_helper'

describe "stats/index" do
  before(:each) do
    assign(:stats, [
      stub_model(Stat,
        :type => "Type",
        :user_id => 1
      ),
      stub_model(Stat,
        :type => "Type",
        :user_id => 1
      )
    ])
  end

  it "renders a list of stats" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
