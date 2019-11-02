Rails.application.routes.draw do
  
  get 'sessions/new'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :answers
  resources :questions
  resources :users
  
  root "users#index"
end
