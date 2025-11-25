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
  # MOCKUPS NAMESPACE
  # ============================================================================
  
  namespace :mockups do
    # Mockup Journey Explorer - Central hub
    root 'index'
    
    # Public journey mockup (one-pager only)
    get 'landing', to: 'public_landing'
    # Admin namespace
    namespace :admin do
      get 'dashboard'
      get 'owners_list'
      get 'owner_detail'
      get 'owner_create'
      get 'tenants_list'
      get 'tenant_detail'
      get 'properties_list'
      get 'property_detail'
      get 'applications_list'
      get 'rating_form'
      get 'visits_calendar'
      get 'visit_form'
      get 'payments_dashboard'
      get 'payments_list'
      get 'invoices_list'
      get 'invoice_create'
      get 'accounting_export'
    end
    
    # Owner namespace
    namespace :owner do
      get 'dashboard'
      get 'profile_show'
      get 'profile_edit'
      get 'property_step1'
      get 'property_step2_apartment'
      get 'property_step2_house'
      get 'property_step2_room'
      get 'property_step3_building'
      get 'property_step3_room'
      get 'equipment_interface'
      get 'properties_list'
      get 'property_show'
      get 'applications_list'
      get 'application_detail'
      get 'leases_list'
      get 'lease_show'
      get 'lease_preview'
      get 'payment_form'
      get 'payment_success'
      get 'payments_list'
      get 'invoices_list'
      get 'notifications'
    end
    
    # Tenant namespace
    namespace :tenant do
      get 'dashboard'
      get 'profile_show'
      get 'profile_edit'
      get 'documents'
      get 'guarantor_form'
      get 'guarantor_show'
      get 'applications_list'
      get 'application_show'
      get 'leases_list'
      get 'lease_show'
      get 'lease_preview'
      get 'rental_cv'
      get 'notifications'
    end
  end
  
  # ============================================================================
  # DEVELOPMENT ROUTES
  # ============================================================================
  
  # Typography/Design System pages
  get "typography", to: "pages#typography"
  get "typography2", to: "pages#typography2"
  
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
