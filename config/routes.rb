Rails.application.routes.draw do
  get 'users/index'
  get 'users/new'
  get 'users/create'
  resources :users
  root "users#index"
end
