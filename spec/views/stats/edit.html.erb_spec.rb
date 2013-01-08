require 'spec_helper'

describe "stats/edit" do
  before(:each) do
    @stat = assign(:stat, stub_model(Stat,
      :type => "",
      :user_id => 1
    ))
  end

  it "renders the edit stat form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stats_path(@stat), :method => "post" do
      assert_select "input#stat_type", :name => "stat[type]"
      assert_select "input#stat_user_id", :name => "stat[user_id]"
    end
  end
end
