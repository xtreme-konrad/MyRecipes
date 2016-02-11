Rails.application.routes.draw do

  root 'pages#home'
  
  get '/home', to: 'pages#home'
  get '/register', to: 'chefs#new'
  
  get '/login', to: 'logins#new'
  post '/login', to: 'logins#create'
  get '/logout', to: 'logins#destroy'

  resources :recipes do
    member do
      post 'like'
    end
  end
  
  resources :chefs, except: [:new]
  
  resources :ingredients, only: [:new, :create, :show]
  resources :styles, only: [:new, :create, :show]
  
end
