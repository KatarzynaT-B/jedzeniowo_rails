Jedzeniowo::Application.routes.draw do
  get "pages/home"
  get "pages/about"

  resources :users

  match "/about", to: 'pages#about', via: 'get'
  match "/signup", to: 'users#new', via: 'get'

  root 'pages#home'
end
