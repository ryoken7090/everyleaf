Rails.application.routes.draw do
  resources :tags, only: [:new, :create, :index, :destroy]
  namespace :admin do
    resources :users
  end
  resources :tasks
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  root to: "tasks#index"
end
