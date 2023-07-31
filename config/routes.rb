Rails.application.routes.draw do

  root "users#index"
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :posts do
    collection do
      get 'confirm'
    end
  end
  get '/index', to:'posts#index'
end
