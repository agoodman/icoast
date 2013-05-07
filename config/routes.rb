Usgs::Application.routes.draw do

  resources :images
  get '/images/pre/:position' => 'images#pre'
  get '/images/post/:position' => 'images#post'
  get '/images/nearest_pre/:position' => 'images#nearest_pre'
  get '/images/nearest_post/:position' => 'images#nearest_post'
  
  namespace :admin do
    resources :images
  end
  
  root to: 'images#index'

end
