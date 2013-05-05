Usgs::Application.routes.draw do

  resources :images do
    member do
      get :pre
      get :post
      get :nearest_pre
      get :nearest_post
    end
  end
  
  root to: 'images#index'

end
