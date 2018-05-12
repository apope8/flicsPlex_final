Rails.application.routes.draw do
  devise_for :admins
  get 'orderitems/index'

  get 'orderitems/show'

  get 'orderitems/new'

  get 'orderitems/edit'

  resources :orders
  
  
  resources :categories
  
  
  devise_for :users do
    resources:orders
  end
  
  get '/checkout', to: 'cart#createOrder'
  
  get '/paid', to: 'static_pages#paid'
  
  
  get 'cart/index'
  
  

  resources :movies
  root 'static_pages#home'
  
  get '/help', to: 'static_pages#help'

  get '/about', to: 'static_pages#about'
  
  get '/login', to: 'user#login'
  
  get '/logout', to: 'user#logout'
  
  get '/admins/sign_in', to: 'admins#sign_in'
  
  get '/admins/sign_out', to: 'admins#sign_out'
  
  
  
  
  get '/cart', to: 'cart#index'
  #allow user to call the add method from the URL with a button click
  get '/cart/:id', to: 'cart#add'
  
  
  get 'cart/remove/:id', to: 'cart#remove'
  
  get 'clearCart/', to: 'cart#clearCart'
  
  post '/search', to: 'movies#search'
  
  root :to => 'site#home'
  
  
  get 'category/:title', to:'static_pages#category'
  
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
