Rails.application.routes.draw do
  root 'store#index', as: 'store_index', via: :all
  match '*path', to: redirect('404'), via: :all, constraints: -> (req) { req.headers['User-Agent'] =~ FIREFOX_BROWSER_REGEX }

  get 'store' => 'store#index'
  get 'after_login' => 'admin#index'
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

  resources :products, path: '/books' do
    get :who_bought, on: :member
  end

  resources :categories do
    resources :products, path: '/books', as: 'books', constraints: { category_id: CATEGORY_ID_REGEX }
    resources :products, path: '/books', as: 'books', to: redirect('/')
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
