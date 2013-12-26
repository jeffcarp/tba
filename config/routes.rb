Shanghai::Application.routes.draw do


  # Stats
  match 'stats/image/:user_id/:issue_id', :to => 'stats#image'
  match 'stats/email',                    :to => 'stats#email'
  match 'stats/issues',                   :to => 'stats#issues'
  match 'stats/users',                    :to => 'stats#users'
  match 'stats',			                    :to => 'stats#index'

  get "accounts/update"

  match '/auth/:provider/callback', :to => 'sessions#create'
  match "/logout" => "sessions#destroy", :as => :signout

  resources :users
  resources :posts
  resources :issues
  resources :votes
  resources :accounts
  resources :comments

  get '/compose'     => 'posts#new', :as => 'compose'

  get "posts/:id/upvote" => "posts#upvote"
  get "posts/:id/downvote" => "posts#downvote"

  get "about" => "home#about"

  # API (access with .json)
  get "popular" => "posts#popular"

  get "newest" => "posts#newest"

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"

  get '/auth' => 'home#auth', :as => 'auth'
  get '/settings'    => 'home#settings', :as => 'settings'

  post '/' => 'users#create', :as => 'home'

  root :to => "home#index"
end
