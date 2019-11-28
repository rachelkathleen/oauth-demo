Rails.application.routes.draw do

  resources :users
  root 'sessions#welcome'
  
  get '/signup' => 'users#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  get '/dashboard' => 'users#dashboard'

  #routes for omniauth
  get '/auth/:provider/callback' => 'sessions#omniauth'


  get '*path' => redirect('/')

end