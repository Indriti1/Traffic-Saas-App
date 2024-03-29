Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_checks

  # Root route
  root 'notifications#main'

  # Authentication routes
  get '/login' => 'sessions#new'
  post '/login' =>'sessions#create'
  get '/signup' => 'registrations#new'
  post '/signup' => 'registrations#create'
  delete '/logout' => 'sessions#destroy'

  # User routes
  resources :users, only:[:show, :update, :edit] do
    get 'vehicles', on: :member
    get 'fines', on: :member
  end

  # Notification routes
  resources :notifications do
    patch 'publish', on: :member
  end

  # Vehicle routes
  resources :vehicles

  # Fine routes
  resources :fines do
    get 'payment', on: :member, to: 'payments#new'
    post 'payment', on: :member, to: 'payments#pay'
  end

end
