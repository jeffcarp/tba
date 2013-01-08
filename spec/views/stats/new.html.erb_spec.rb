require 'spec_helper'

describe "stats/new" do
  before(:each) do
    assign(:stat, stub_model(Stat,
      :type => "",
      :user_id => 1
    ).as_new_record)
  end

  it "renders new stat form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stats_path, :method => "post" do
      assert_select "input#stat_type", :name => "stat[type]"
      assert_select "input#stat_user_id", :name => "stat[user_id]"
    end
  end
end
