Jedzeniowo::Application.routes.draw do
  get "pages/home"
  get "pages/about"

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  match "/about", to: 'pages#about', via: 'get'
  match "/signup", to: 'users#new', via: 'get'
  match "/signin", to: 'sessions#new', via: 'get'
  match "/signout", to: 'sessions#destroy', via: 'delete'

  root 'pages#home'
end
