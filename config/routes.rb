Rails.application.routes.draw do
  resource :users, only: [:update], as: 'user'
  devise_for :users

  resources :topics do
    resources :posts, except: [:index]
  end

  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
  end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
