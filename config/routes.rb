Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'

  resources :posts
  resources :users, only: %i[index]
  resources :categories, only: %i[index show new create edit update]

  get :search, to: 'posts#search'
end
