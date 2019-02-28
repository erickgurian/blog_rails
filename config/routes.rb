Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'

  resources :posts, only: %i[index show new create]
  resources :users, only: %i[index]
end
