Shanghai::Application.routes.draw do
  resources :users
  resources :posts

  get '/success' => 'home#success'

  root :to => 'home#index'
end
