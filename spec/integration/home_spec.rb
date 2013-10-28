require 'spec_helper'

describe 'home page' do
  it 'has the text The Better Announcements' do
    visit '/'
    page.should_not have_content('Today\'s Announcements')
  end
end
