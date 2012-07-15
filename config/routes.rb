Shanghai::Application.routes.draw do

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
  
  post '/' => 'users#create', :as => 'home'

#   get '/auth' => 'home#auth', :constraints => lambda{ |req| !req.params[:l].blank? }

  root :to => 'home#index'
end
