Rails.application.routes.draw do
  resources :users, only: [:new, :create, :index]
  namespace :admin do
    resources :users
  end
  root to: 'tasks#index'
  resources :tasks
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]

end
