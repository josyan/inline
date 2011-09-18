GlassVision::Application.routes.draw do

  resources :emails
  match '/signup', :to => 'users#new', :as => :signup
  match '/login', :to => 'session#new', :as => :login
  match '/logout', :to => 'session#destroy', :as => :logout
  match '/activate/:id', :to => 'accounts#show', :as => :activate
  match '/forgot_password', :to => 'passwords#new', :as => :forgot_password
  match '/reset_password/:id', :to => 'passwords#edit', :as => :reset_password
  match '/change_password', :to => 'accounts#edit', :as => :change_password

  resources :users do
    post :enable
    post :disable
    resource :account
    resources :roles
  end

  resources :product_colors
  resources :shapes
  resource :session, :controller => :session
  resource :passwords
  resources :quotations, :controller => :quotation do
    get :print
    get :print_invoice
    get :print_calculations
    get :print_manifest
  end
  root :to => 'home#index'

  match '/:controller(/:action(/:id))'
end

