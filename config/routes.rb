Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :shops
  resources :comments, only: %i[create destroy]
  get 'home/top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#top'
  post "likes/:shop_id/create", to: "likes#create"
  post "likes/:shop_id/destroy", to: "likes#destroy"
end
