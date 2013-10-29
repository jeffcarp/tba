require 'spec_helper'

describe 'Integration Routes' do

  it 'GET /' do
    get '/'
    response.should be_success
  end

  it 'GET /today' do
    get '/today'
    response.should be_success
  end

  it 'GET /tommorrow' do
    get '/tomorrow'
    response.status.should == 302 
  end

  it 'GET /compose' do
    get '/compose'
    response.should be_success
  end

  it 'GET /guide' do
    get '/guide'
    response.should be_success
  end

end
