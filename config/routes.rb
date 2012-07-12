Shanghai::Application.routes.draw do
  get "sessions/new"

  resources :users
  resources :posts
  resources :issues

  get '/success' => 'home#success', :as => 'success'
  get '/debug_email' => 'home#debug_email'
  get '/auth' => 'home#auth', :as => 'auth'
  get '/settings' => 'home#settings', :as => 'settings'
  get '/compose' => 'home#compose', :as => 'compose'
  
#   get '/auth' => 'home#auth', :constraints => lambda{ |req| !req.params[:l].blank? }

  root :to => 'home#index'
end
