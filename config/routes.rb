Rails.application.routes.draw do
  resources :users
  get '/users/:id', to: 'users#show'
  get '/users/:user_id/posts', to: 'posts#index'
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
