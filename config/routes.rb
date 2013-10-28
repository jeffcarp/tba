class LoggedInConstraint
  def initialize(value)
    @value = value
  end

  def matches?(request)
    request.cookies.key?("user_id") == @value
  end
end

Shanghai::Application.routes.draw do

  # Stats
  match 'stats/image/:user_id/:issue_id', :to => 'stats#image'
  match 'stats/email',                    :to => 'stats#email'
  match 'stats/issues',                   :to => 'stats#issues'
  match 'stats/users',                    :to => 'stats#users'
  match 'stats',			                    :to => 'stats#index'

  get "accounts/update"

  get "search" => "home#search"

  match '/auth/:provider/callback', :to => 'sessions#create'
  match "/logout" => "sessions#destroy", :as => :signout

  match "/votes/mail/:post_id", :to => "votes#mail"

  get "mobile/dashboard" => "mobile#dashboard"
  get "mobile/foss"      => "mobile#foss"
  get "mobile/dana"      => "mobile#dana"
  get "mobile/bobs"      => "mobile#bobs"

  resources :users
  resources :posts
  resources :issues
  resources :votes
  resources :accounts

  get "accounts/:id/unsubscribe" => "accounts#unsubscribe", :as => "unsubscribe"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get '/success' => 'home#success', :as => 'success'
  get '/debug_email' => 'home#debug_email'
  get '/auth' => 'home#auth', :as => 'auth'
  get '/settings'    => 'home#settings', :as => 'settings'
  get '/compose'     => 'posts#compose', :as => 'compose'
  get '/guide'       => 'home#guide',    :as => 'guide'
  get '/help'        => 'home#help',     :as => 'help'
  get '/tomorrow'    => 'home#tomorrow', :as => 'tomorrow'

  post '/' => 'users#create', :as => 'home'

#   get '/auth' => 'home#auth', :constraints => lambda{ |req| !req.params[:l].blank? }

  root :to => "home#index", :constraints => LoggedInConstraint.new(false)
  root :to => "home#dashboard", :constraints => LoggedInConstraint.new(true)

  # root :to => 'home#index'
end
