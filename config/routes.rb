Rails.application.routes.draw do
  resources :categories

  get 'store' => 'store#index'
  get 'after_login' => 'admin#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end



  get 'sessions/create'
  get 'sessions/destroy'

  get "users/orders", to: "users#orders"
  get "users/line_item", to: "users#line_item"
  resources :users

  resources :products do
    get :who_bought, on: :member
  end

  resources :support_requests, only: [ :index, :update ]

    resources :orders
    resources :line_items
    resources :carts
    resources :categories
    root 'store#index', as: 'store_index', via: :all
  
    namespace :admin do
      get 'reports', to: 'reports#index'
      post 'reports', to: 'reports#index'
      get 'categories', to: 'categories#index'
    end
end
