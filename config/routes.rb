Rails.application.routes.draw do
  resource :users, only: [:update], as: 'user'
  devise_for :users

  resources :topics do
    resources :posts
  end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
