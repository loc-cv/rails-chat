Rails.application.routes.draw do
  root 'pages#home'
  resources :rooms

  devise_for :users
  devise_scope :user do
    get :users, to: 'devise/sessions#new'
  end
  get 'users/:id', to: 'users#show', as: :user
end
