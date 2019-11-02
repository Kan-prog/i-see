Rails.application.routes.draw do
  resources :answers
  resources :questions
  resources :users
  
  root "users#index"
end
