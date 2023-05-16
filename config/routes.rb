Rails.application.routes.draw do
  root 'store#index', as: 'store_index', via: :all
  match '*path', to: redirect('404'), via: :all, constraints: -> (req) { req.headers['User-Agent'] =~ FIREFOX_BROWSER_REGEX }

  get 'store' => 'store#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end



  get 'sessions/create'
  get 'sessions/destroy'

  resources :users
  controller :users do
    get 'my-items' => :line_items
    get 'my-orders' => :orders
  end

  resources :products, path: '/books' do
    get :who_bought, on: :member
  end

  resources :categories do
    resources :books, controller: 'products', constraints: { category_id: INTEGER_ID_REGEX }
    resources :books, controller: 'products', to: redirect('/')
  end

  resources :support_requests, only: [ :index, :update ]

    resources :orders
    resources :line_items
    resources :carts

  
    namespace :admin do
      get 'reports', to: 'reports#index'
      post 'reports', to: 'reports#index'
      get 'categories', to: 'categories#index'
    end
end
