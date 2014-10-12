Rails.application.routes.draw do
  resource :users, only: [:update], as: 'user'
  devise_for :users

  resources :topics do
    resources :posts do
      resources :comments, only: [:create]
    end
  end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
