Rails.application.routes.draw do

  root "toppage#top"
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users do
    get 'mypage', on: :collection
    get 'empathy', on: :collection
  end

  resources :posts do
    get 'draft', on: :collection
    get 'empathy', on: :collection
    resource :empathy, only: %i[create destroy]
  end

  get '/index', to:'posts#index'

  resource :polices, only: [] do
    collection do
      get :privacy
      get :service
    end
  end
end