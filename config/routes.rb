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

  resources :doors do
    collection do
      get 'configure_panels'
      get 'configure_glass_families'
      get 'configure_glasses'
      get 'configure_openings'
    end
  end
  resources :door_frames
  resources :door_combinations
  resources :frame_profiles
  resources :door_panels
  resources :door_openings
  resources :door_glass_families do
    resources :door_glasses
  end
  resources :door_borings
  resources :door_sections do
    resources :door_section_dimensions
  end

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

