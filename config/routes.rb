Rails.application.routes.draw do
  devise_for :admins

  resources :users
  resources :posts
  resources :dashboards

  get '/login', to: 'users#check_login'
  post '/login', to: 'users#login'
  get '/logout', to: 'users#logout'
  root 'dashboards#index'
end
