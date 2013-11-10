require 'spec_helper'

describe 'Integration Routes' do

  it 'GET /' do
    get '/'
    response.should be_success
  end

end
