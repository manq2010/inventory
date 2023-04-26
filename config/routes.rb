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
    resources :items, only: [:index, :create, :destroy, :show, :update]
    resources :users, only: [:index, :show, :update, :destroy]
    resources :sales, only: [:index, :create, :destroy, :show, :update]
    resources :orders
    post '/signup', to: 'users#create'
  end
end

post '/login', to: 'sessions#create'
end
