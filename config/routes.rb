# OLAK Property Rental Platform - Production Routes
# Generated according to doc/routes.md

Rails.application.routes.draw do
  # ============================================================================
  # AUTHENTICATION ROUTES
  # ============================================================================
  
  # Devise routes with custom controllers
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }
  
  # ============================================================================
  # PUBLIC ROUTES
  # ============================================================================
  
  # Root path - Public landing page
  root 'pages#home'
  
  get '/links', to: 'pages#links'
  
  # Public pages

  get :about, to: 'pages#about'
  get :contact, to: 'pages#contact'
  post :contact, to: 'pages#contact_submit'

  
  # Tenant registration via unique link
  get '/candidats/inscription/:token', to: 'tenant_registrations#new', as: :tenant_registration
  post '/candidats/inscription/:token', to: 'tenant_registrations#create'
  
  # Shareable rental CV
  get '/cv-locatif/:token', to: 'rental_cvs#show', as: :rental_cv
  
  # ============================================================================
  # ADMIN NAMESPACE
  # ============================================================================
  
  # Admin routes - requires admin role
  # authenticate :user, ->(user) { user.admin? } do
    namespace :admin do
      # Dashboard root
      root 'dashboard#index'
      
      # Owner Management
      resources :owners, only: [:index, :show, :new, :create, :edit, :update] do
        member do
          patch :validate
          patch :reject
        end
      end
      
      # Tenant Management
      resources :tenants, only: [:index, :show] do
        member do
          patch :validate_documents
        end
      end
      
      # Property Management (View only)
      resources :properties, only: [:index, :show]
      
      # Application Management
      resources :applications, only: [:index, :show] do
        member do
          post :propose_to_owner
        end
      end
      
      # Rating Management
      resources :ratings, only: [:new, :create, :edit, :update, :show]
      
      # Visit Calendar
      resources :visits, only: [:index, :new, :create, :edit, :update, :destroy]
      
      # Payment Dashboard
      resources :payments, only: [:index, :show] do
        collection do
          get :dashboard
          get :export
        end
      end
      
      # Invoice Management
      resources :invoices, only: [:index, :show, :new, :create] do
        member do
          get :download
        end
      end
      
      # Accounting Export
      resources :accounting_exports, only: [:index, :create] do
        member do
          get :download
        end
      end
    end
  # end
  
  # ============================================================================
  # OWNER NAMESPACE
  # ============================================================================
  
  # Owner routes - requires owner role
  # authenticate :user, ->(user) { user.owner? } do
    namespace :owner do
      # Dashboard root
      root 'dashboard#index'
      
      # Dashboard
      resources :dashboard, only: [:index]
      
      # Profile Management
      resource :profile, only: [:show, :edit, :update]
      
      # Property Management with wizard steps
      resources :properties do
        member do
          get :wizard_step_two
          get :wizard_step_three
          patch :update_step_two
          patch :update_step_three
          patch :publish
          patch :archive
        end
        
        # Nested resources for property details
        resources :property_equipments, only: [:create, :destroy]
        resources :property_amenities, only: [:create, :destroy]
        resources :property_private_accessories, only: [:create, :destroy]
        
        resources :heating_systems, only: [:create, :update, :destroy] do
          resources :heating_equipments, only: [:create, :destroy]
        end
        
        resources :property_improvements, only: [:create, :update, :destroy]
      end
      
      # Application Management
      resources :applications, only: [:index, :show] do
        member do
          patch :accept
          patch :reject
        end
      end
      
      # Lease Management
      resources :leases, only: [:index, :show] do
        member do
          get :preview
          post :request_signature
          get :download
        end
      end
      
      # Payment Management
      resources :payments, only: [:index, :show, :new, :create] do
        member do
          get :success
          get :cancel
        end
      end
      
      # Invoice Management
      resources :invoices, only: [:index, :show] do
        member do
          get :download
        end
      end
      
      # Notifications
      resources :notifications, only: [:index, :show] do
        member do
          patch :mark_as_read
        end
      end
    end
  # end
  
  # ============================================================================
  # TENANT NAMESPACE
  # ============================================================================
  
  # Tenant routes - requires tenant role
  # authenticate :user, ->(user) { user.tenant? } do
    namespace :tenant do
      # Dashboard root
      root 'dashboard#index'
      
      # Dashboard
      resources :dashboard, only: [:index]
      
      # Profile Management
      resource :profile, only: [:show, :edit, :update] do
        member do
          get :documents
          patch :upload_documents
        end
      end
      
      # Guarantor Management
      resource :guarantor, only: [:show, :new, :create, :edit, :update, :destroy]
      
      # Applications
      resources :applications, only: [:index, :show] do
        member do
          patch :withdraw
        end
      end
      
      # Leases
      resources :leases, only: [:index, :show] do
        member do
          get :preview
          post :sign
          get :download
        end
      end
      
      # Rental CV
      resource :rental_cv, only: [:show] do
        member do
          get :download
          post :generate_share_link
        end
      end
      
      # Notifications
      resources :notifications, only: [:index, :show] do
        member do
          patch :mark_as_read
        end
      end
    end
  # end
  
  # ============================================================================
  # API NAMESPACE (Webhooks)
  # ============================================================================
  
  namespace :api do
    namespace :v1 do
      # SignNow webhooks
      post '/webhooks/signnow', to: 'webhooks#signnow'
      
      # Stripe webhooks
      post '/webhooks/stripe', to: 'webhooks#stripe'
    end
  end
  
  # ============================================================================
  # EXISTING MOCKUP & DEVELOPMENT ROUTES
  # ============================================================================

  get "home/index"
  get "typography", to: "pages#typography"
  get "typography2", to: "pages#typography2"
  # devise_for :users  # Commented out - already defined on line 10 with custom controllers
  
  # Mockups routes
  get 'mockups/index'
  
  # Admin mockups
  get 'mockups/admin_users'
  get 'mockups/admin_analytics'
  
  # Owner mockups
  
  # Tenant mockups
  
  # Legacy user mockups
  get 'mockups/user_dashboard'
  get 'mockups/user_profile'
  get 'mockups/user_settings'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "mockups#index"  # Commented out - production root is already defined on line 22
end
