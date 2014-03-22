Jedzeniowo::Application.routes.draw do
  get "dishes/index"
  get "dishes/show"
  get "dishes/new"
  get "dishes/edit"
  get "dishes/create"
  get "dishes/update"
  get "dishes/destroy"
  get "pages/home"
  get "pages/about"

  resources :users
  resources :products, except: :show
  resources :sessions, only: [:new, :create, :destroy]
  resources :dishes

  match "/about", to: 'pages#about', via: 'get'
  match "/signup", to: 'users#new', via: 'get'
  match "/signin", to: 'sessions#new', via: 'get'
  match "/signout", to: 'sessions#destroy', via: 'delete'

  root 'pages#home'
end
