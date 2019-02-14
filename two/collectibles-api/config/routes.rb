Rails.application.routes.draw do
  resources :games

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
