Rails.application.routes.draw do

  root 'pages#home'
  
  get '/home', to: 'pages#home'
  get '/register', to: 'chefs#new'

  resources :recipes do
    
    member do
      post 'like'
    end
    
  end
  
  resources :chefs, except: [:new]
  
end
