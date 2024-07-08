
Rails.application.routes.draw do
  resources :lessons
  devise_for :users
  resources :lounges
  get 'pages/home'

  root 'pages#home'
  resources :students
  resources :teachers
  
end
