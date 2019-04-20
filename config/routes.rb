Rails.application.routes.draw do
=begin original
  get 'register', to: 'users#new'
  post 'users', to: 'users#create'
  get 'connect', to: 'connections#create'
  get 'state', to: 'connections#index'
  post 'update', to: 'users#update'
  root to: 'users#show'
=end
  get 'register', to: redirect('/')
  post 'users', to: redirect('/')
  get 'connect', to: redirect('/')
  get 'state', to: redirect('/')
  post 'update', to: redirect('/')

  root to: 'connections#index'
end

