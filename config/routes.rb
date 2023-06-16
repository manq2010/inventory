Rails.application.routes.draw do
  devise_for :users, path: '',
  path_names: {
    sign_in: 'login', 
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get '/member-data', to: 'members#show'
  get 'current_user', to: 'current_user#index' 


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
    resources :customers, only: [:index, :create, :destroy, :show, :update]
    resources :sales, only: [:index, :create, :destroy, :show, :update] do
      member do
        post 'items', to: 'items_sales#add_item'
        get 'items', to: 'items_sales#sale_items_data'
        put 'items/:item_id', to: 'items_sales#update_item'
        delete 'items/:item_id', to: 'items_sales#delete_item'
      end
    end
    
    resources :orders
    post '/signup', to: 'users#create'
  end
end

post '/login', to: 'sessions#create'
end
