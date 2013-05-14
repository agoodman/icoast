Usgs::Application.routes.draw do

  get '/images' => 'images#index'
  get '/images/pre' => 'images#index_pre'
  get '/images/post' => 'images#index_post'
  get '/images/post/random' => 'images#random_post'
  get '/images/pre/:position' => 'images#pre'
  get '/images/post/:position' => 'images#post'
  get '/images/nearest_pre/:position' => 'images#nearest_pre'
  get '/images/nearest_post/:position' => 'images#nearest_post'
  
  resources :annotations
  
  namespace :admin do
    resources :images
    resources :tags
  end
  
  root to: 'images#index'

end
