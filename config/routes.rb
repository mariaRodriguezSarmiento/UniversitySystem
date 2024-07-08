
Rails.application.routes.draw do
  resources :lessons do
    get 'new_student', on: :member
    post 'create_student', on: :member
  end
  devise_for :users
  resources :lounges
  get 'pages/home'

  root 'pages#home'
  resources :students
  resources :teachers
  
end
