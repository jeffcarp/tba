require 'spec_helper'

describe 'Public Routes' do

  @user = User.create!({name: "Cool Dude"})
  @post = Post.create!({content: "Chicken", title: "Cow", user_id: @user.id})

  get_routes = %W{
    /
    /newest
    /popular.json
    /posts/#{@post.id}
    /posts/#{@post.id}.json
  }

  get_routes.each do |r|
    it 'GET '+r do
      get r 
      response.should be_success
    end
  end

end
