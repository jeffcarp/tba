class LoggedInConstraint
  def initialize(value)
    @value = value
  end

  def matches?(request)
    request.session.key?("user_id") == @value
  end
end

Shanghai::Application.routes.draw do

  match '/auth/:provider/callback', :to => 'sessions#create'
  match "/logout" => "sessions#destroy", :as => :signout

  resources :users
  resources :posts
  resources :issues

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get '/success' => 'home#success', :as => 'success'
  get '/debug_email' => 'home#debug_email'
  get '/auth' => 'home#auth', :as => 'auth'
  get '/settings' => 'home#settings', :as => 'settings'
  get '/compose' => 'posts#compose', :as => 'compose'
  get '/guide' => 'home#guide', :as => 'guide'
  get '/stats' => 'home#stats', :as => 'stats'

  post '/' => 'users#create', :as => 'home'

#   get '/auth' => 'home#auth', :constraints => lambda{ |req| !req.params[:l].blank? }

  root :to => "home#index", :constraints => LoggedInConstraint.new(false)
  root :to => "home#dashboard", :constraints => LoggedInConstraint.new(true)

  # root :to => 'home#index'
end
