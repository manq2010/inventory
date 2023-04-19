Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: redirect('/api-docs')

  # config/routes.rb
namespace :api do
  namespace :v1 do
    resources :items, only: [:index, :create, :destroy]
    resources :users, only: [:index, :update, :destroy]
    resources :sales
    resources :orders
    post '/signup', to: 'users#create'
  end
end

post '/login', to: 'sessions#create'
end
