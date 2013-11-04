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

  resources :users
  resources :posts
  resources :issues
  resources :votes
  resources :accounts

  get "posts/:id/upvote" => "posts#upvote"
  get "posts/:id/downvote" => "posts#downvote"

  get "newest" => "posts#newest"

  get "accounts/:id/unsubscribe" => "accounts#unsubscribe", :as => "unsubscribe"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get '/success' => 'home#success', :as => 'success'
  get '/debug_email' => 'home#debug_email'
  get '/auth' => 'home#auth', :as => 'auth'
  get '/settings'    => 'home#settings', :as => 'settings'
  get '/compose'     => 'posts#new', :as => 'compose'
  get '/guide'       => 'home#guide',    :as => 'guide'
  get '/help'        => 'home#help',     :as => 'help'
  get '/tomorrow'    => 'home#tomorrow', :as => 'tomorrow'

  post '/' => 'users#create', :as => 'home'

  root :to => "home#index"
end
