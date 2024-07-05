# frozen_string_literal: true

Rails.application.routes.draw do
  resources :likes, only: %i[create destroy]
  resources :comments

  devise_for :users
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users, only: [:show]

  post 'users/:id/follow', to: 'users#follow', as: 'follow'
  post 'users/:id/unfollow', to: 'users#unfollow', as: 'unfollow'
  post 'users/:id/accept', to: 'users#accept', as: 'accept'
  post 'users/:id/decline', to: 'users#decline', as: 'decline'
  post 'users/:id/cancel', to: 'users#cancel', as: 'cancel'

  get 'posts/feed'
  get 'posts/myposts'
  resources :posts

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'posts#index'
end
