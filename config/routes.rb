Rails.application.routes.draw do
  get 'register', to: 'users#new'
  post 'users', to: 'users#create'
  get 'connect', to: 'connections#create'
  get 'state', to: 'connections#index'

  root to: 'users#show'
end
