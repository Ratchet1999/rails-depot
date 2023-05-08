Rails.application.routes.draw do
  get 'admin' => 'admin#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get 'sessions/create'
  get 'sessions/destroy'

  get 'users/line_items', to: 'users#line_items'
  get 'users/orders', to: 'users#orders'

  resources :users

  resources :products do
    get :who_bought, on: :member
  end

  resources :support_requests, only: [ :index, :update ]
  
  scope '(:locale)' do
    resources :orders
    resources :line_items
    resources :carts
    resources :categories
    root 'store#index', as: 'store_index', via: :all
  end
end
