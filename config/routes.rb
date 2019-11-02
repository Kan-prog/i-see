Rails.application.routes.draw do
  
  get 'sessions/new'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  # resources :answers
  
  resources :questions do
    resources :answers, only: [:create]
  end
  
  resources :users
  
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :questions
    end
  end
  
  root "questions#index"
end
