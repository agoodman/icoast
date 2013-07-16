Usgs::Application.routes.draw do

  devise_for :users, controllers: { sessions: :sessions, registrations: :registrations, passwords: :passwords }

  get '/images' => 'images#alt'
  get '/images/alt' => 'images#index'
  get '/images/pre' => 'images#index_pre'
  get '/images/post' => 'images#index_post'
  get '/images/post/random' => 'images#random_post'
  get '/images/pre/:position' => 'images#pre'
  get '/images/post/:position' => 'images#post'
  get '/images/nearest_pre/:position' => 'images#nearest_pre'
  get '/images/nearest_post/:position' => 'images#nearest_post'
  get '/matches/:pre/:post' => 'matches#exists'
  
  resources :annotations
  resources :analytics, only: :index
  resources :matches
  resources :comments
  
  namespace :admin do
    resources :images do
      collection do
        get 'pre' => 'images#index_pre'
        get 'post' => 'images#index_post'
      end
    end
    resources :tags
    root to: 'analytics#index'
  end
  
  root to: 'home#index'

end
