Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do

      get '/search', to: 'users#search'
      end
  end

  get '/member-data', to: 'members#show'
  get 'current_user', to: 'current_user#index' 

  get 'users/index'
  scope :api do
    scope :v1 do
      devise_for :users,
                 path: 'auth',
                 path_names: {
                   sign_in: 'login',
                   sign_out: 'logout',
                   registration: 'signup'
                 },
                 controllers: {
                   registrations: 'api/v1/auth/registrations',
                   sessions: 'api/v1/auth/sessions',
                 }, defaults: { format: :json }
      devise_scope :user do
        get '/auth/me', to: 'api/v1/users#me', as: :user_root
        get '/users', to: 'api/v1/users#index', as: :users
        get '/auth/users/:id', to: 'api/v1/users#show', as: :user
        get '/users/show/:username', to: 'api/v1/users#show_by_username', as: :show_by_username
        put '/auth/users/:id', to: 'api/v1/users#update', as: :update_user
        delete '/auth/users', to: 'api/v1/users#destroy', as: :destroy_user
        # post 'password/forgot', to: 'api/v1/password#forgot'
        # post 'password/reset', to: 'api/v1/password#reset'
      end
    end
  end
  
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
    # post '/signup', to: 'users#create'
  end
end

# post '/login', to: 'sessions#create'
end
