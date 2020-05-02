Rails.application.routes.draw do
  root 'home#top'
  get 'home/top', to: 'home#top'
  get "/timeline", to: "home#timeline"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :shops
  resources :comments, only: %i[create destroy]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/guest', to: 'sessions#guest_login'
  delete '/logout', to: 'sessions#destroy'
  post "likes/:shop_id/create", to: "likes#create"
  post "likes/:shop_id/destroy", to: "likes#destroy"
  resources :relationships, only: [:create, :destroy]
end
