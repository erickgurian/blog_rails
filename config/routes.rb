Rails.application.routes.draw do
  root to: 'posts#index'

  resources :posts, only: %i[index show new create]
end
