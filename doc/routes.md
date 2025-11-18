# Routes - OLAK Platform

## Overview

This document describes all the routes for the OLAK property rental platform. Routes are organized by namespace according to user roles (admin, owner, tenant) and public pages.

## Authentication Routes

### Devise Routes (User Authentication)

```ruby
# Public authentication
devise_for :users, controllers: {
  registrations: 'users/registrations',
  sessions: 'users/sessions',
  passwords: 'users/passwords',
  confirmations: 'users/confirmations'
}
```

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/users/sign_up` | `users/registrations#new` | Registration form (redirects to role-specific after) |
| POST | `/users` | `users/registrations#create` | Create new user account |
| GET | `/users/sign_in` | `users/sessions#new` | Login page |
| POST | `/users/sign_in` | `users/sessions#create` | Login action |
| DELETE | `/users/sign_out` | `users/sessions#destroy` | Logout action |
| GET | `/users/password/new` | `users/passwords#new` | Forgot password form |
| POST | `/users/password` | `users/passwords#create` | Send password reset email |
| GET | `/users/password/edit` | `users/passwords#edit` | Reset password form |
| PATCH | `/users/password` | `users/passwords#update` | Update password |
| GET | `/users/confirmation/new` | `users/confirmations#new` | Resend confirmation email form |
| POST | `/users/confirmation` | `users/confirmations#create` | Resend confirmation email |
| GET | `/users/confirmation` | `users/confirmations#show` | Email confirmation callback |

---

## Public Routes

```ruby
root 'pages#home'

resources :pages, only: [] do
  collection do
    get :home
    get :about
    get :contact
    post :contact_submit
  end
end
```

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/` | `pages#home` | Public landing page announcing Olak's arrival |
| GET | `/about` | `pages#about` | About page (optional) |
| GET | `/contact` | `pages#contact` | Contact form |
| POST | `/contact` | `pages#contact_submit` | Submit contact form |

### Tenant Registration (via link)

```ruby
get '/candidats/inscription/:token', to: 'tenant_registrations#new', as: :tenant_registration
post '/candidats/inscription/:token', to: 'tenant_registrations#create'
```

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/candidats/inscription/:token` | `tenant_registrations#new` | Tenant registration form via unique link |
| POST | `/candidats/inscription/:token` | `tenant_registrations#create` | Create tenant account |

### Shareable Rental CV

```ruby
get '/cv-locatif/:token', to: 'rental_cvs#show', as: :rental_cv
```

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/cv-locatif/:token` | `rental_cvs#show` | Public view of tenant's rental CV (shareable link) |

---

## Admin Namespace

```ruby
namespace :admin do
  root 'dashboard#index'
  
  # Dashboard & Statistics
  resource :dashboard, only: [:index]
  
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
```

### Admin Dashboard

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/admin` | `admin/dashboard#index` | Main admin dashboard with platform overview, pending validations, recent activities |

### Owner Management (Admin)

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/admin/owners` | `admin/owners#index` | List of all owners (pending, validated, rejected) with filters |
| GET | `/admin/owners/new` | `admin/owners#new` | Form to manually create owner account |
| POST | `/admin/owners` | `admin/owners#create` | Create owner account |
| GET | `/admin/owners/:id` | `admin/owners#show` | Owner profile details, documents, properties |
| GET | `/admin/owners/:id/edit` | `admin/owners#edit` | Edit owner information |
| PATCH | `/admin/owners/:id` | `admin/owners#update` | Update owner information |
| PATCH | `/admin/owners/:id/validate` | `admin/owners#validate` | Manually validate owner account |
| PATCH | `/admin/owners/:id/reject` | `admin/owners#reject` | Reject owner account with reason |

### Tenant Management (Admin)

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/admin/tenants` | `admin/tenants#index` | List of all tenant candidates with status filters |
| GET | `/admin/tenants/:id` | `admin/tenants#show` | Tenant profile with documents, applications, ratings |
| PATCH | `/admin/tenants/:id/validate_documents` | `admin/tenants#validate_documents` | Manually validate tenant documents |

### Property Management (Admin - View Only)

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/admin/properties` | `admin/properties#index` | List of all properties (filterable by status, owner, type) |
| GET | `/admin/properties/:id` | `admin/properties#show` | Property details with documents, applications |

### Application Management (Admin)

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/admin/applications` | `admin/applications#index` | List of all applications with filters (pending, proposed, accepted) |
| GET | `/admin/applications/:id` | `admin/applications#show` | Application details with tenant info and rating |
| POST | `/admin/applications/:id/propose_to_owner` | `admin/applications#propose_to_owner` | Propose candidate to property owner (after rating) |

### Rating Management (Admin)

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/admin/ratings/new?application_id=:id` | `admin/ratings#new` | Multidimensional rating form for tenant candidate |
| POST | `/admin/ratings` | `admin/ratings#create` | Create rating for application |
| GET | `/admin/ratings/:id` | `admin/ratings#show` | View rating details |
| GET | `/admin/ratings/:id/edit` | `admin/ratings#edit` | Edit existing rating |
| PATCH | `/admin/ratings/:id` | `admin/ratings#update` | Update rating |

### Visit Calendar (Admin)

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/admin/visits` | `admin/visits#index` | Calendar view of all scheduled visits with tenant candidates |
| GET | `/admin/visits/new` | `admin/visits#new` | Schedule new visit |
| POST | `/admin/visits` | `admin/visits#create` | Create visit appointment |
| GET | `/admin/visits/:id/edit` | `admin/visits#edit` | Edit visit details |
| PATCH | `/admin/visits/:id` | `admin/visits#update` | Update visit |
| DELETE | `/admin/visits/:id` | `admin/visits#destroy` | Cancel visit |

### Payment Dashboard (Admin)

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/admin/payments` | `admin/payments#index` | List of all payments with filters |
| GET | `/admin/payments/dashboard` | `admin/payments#dashboard` | Payment analytics dashboard (monthly revenue, charts) |
| GET | `/admin/payments/:id` | `admin/payments#show` | Payment details |
| GET | `/admin/payments/export` | `admin/payments#export` | Export payments data (CSV/Excel) |

### Invoice Management (Admin)

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/admin/invoices` | `admin/invoices#index` | List of all invoices |
| GET | `/admin/invoices/new` | `admin/invoices#new` | Manually create invoice form |
| POST | `/admin/invoices` | `admin/invoices#create` | Generate manual invoice |
| GET | `/admin/invoices/:id` | `admin/invoices#show` | Invoice details |
| GET | `/admin/invoices/:id/download` | `admin/invoices#download` | Download invoice PDF |

### Accounting Export (Admin)

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/admin/accounting_exports` | `admin/accounting_exports#index` | List of accounting exports with date range selector |
| POST | `/admin/accounting_exports` | `admin/accounting_exports#create` | Generate accounting export |
| GET | `/admin/accounting_exports/:id/download` | `admin/accounting_exports#download` | Download accounting data (CSV/Excel) |

---

## Owner Namespace

```ruby
namespace :owner do
  root 'dashboard#index'
  
  # Dashboard
  resource :dashboard, only: [:index]
  
  # Profile Management
  resource :profile, only: [:show, :edit, :update]
  
  # Property Management
  resources :properties do
    member do
      get :wizard_step_two
      get :wizard_step_three
      patch :update_step_two
      patch :update_step_three
      patch :publish
      patch :archive
    end
    
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
```

### Owner Dashboard

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/owner` | `owner/dashboard#index` | Owner dashboard: properties overview, pending applications, recent activities |

### Owner Profile

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/owner/profile` | `owner/profile#show` | View owner profile details |
| GET | `/owner/profile/edit` | `owner/profile#edit` | Edit owner profile form |
| PATCH | `/owner/profile` | `owner/profile#update` | Update owner profile (requires admin re-validation if significant changes) |

### Property Management (Owner)

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/owner/properties` | `owner/properties#index` | List owner's properties (draft, active, rented, archived) |
| GET | `/owner/properties/new` | `owner/properties#new` | Step 1: Initial question "Que souhaitez-vous louer?" |
| POST | `/owner/properties` | `owner/properties#create` | Create property (saves step 1 data) |
| GET | `/owner/properties/:id` | `owner/properties#show` | Property details with applications |
| GET | `/owner/properties/:id/edit` | `owner/properties#edit` | Edit property (step 1) |
| PATCH | `/owner/properties/:id` | `owner/properties#update` | Update property (step 1) |
| DELETE | `/owner/properties/:id` | `owner/properties#destroy` | Delete draft property |
| GET | `/owner/properties/:id/wizard_step_two` | `owner/properties#wizard_step_two` | Step 2: Apartment/House/Room form |
| PATCH | `/owner/properties/:id/update_step_two` | `owner/properties#update_step_two` | Save step 2 data |
| GET | `/owner/properties/:id/wizard_step_three` | `owner/properties#wizard_step_three` | Step 3: Building/Chamber form (if applicable) |
| PATCH | `/owner/properties/:id/update_step_three` | `owner/properties#update_step_three` | Save step 3 data |
| PATCH | `/owner/properties/:id/publish` | `owner/properties#publish` | Publish property (change status to active) |
| PATCH | `/owner/properties/:id/archive` | `owner/properties#archive` | Archive property |

### Property Nested Resources (Owner)

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| POST | `/owner/properties/:id/property_equipments` | `owner/property_equipments#create` | Add equipment (AJAX) |
| DELETE | `/owner/properties/:id/property_equipments/:id` | `owner/property_equipments#destroy` | Remove equipment (AJAX) |
| POST | `/owner/properties/:id/property_amenities` | `owner/property_amenities#create` | Add amenity (AJAX) |
| DELETE | `/owner/properties/:id/property_amenities/:id` | `owner/property_amenities#destroy` | Remove amenity (AJAX) |
| POST | `/owner/properties/:id/property_private_accessories` | `owner/property_private_accessories#create` | Add private accessory (AJAX) |
| DELETE | `/owner/properties/:id/property_private_accessories/:id` | `owner/property_private_accessories#destroy` | Remove private accessory (AJAX) |
| POST | `/owner/properties/:id/heating_systems` | `owner/heating_systems#create` | Add heating system |
| PATCH | `/owner/properties/:id/heating_systems/:id` | `owner/heating_systems#update` | Update heating system |
| DELETE | `/owner/properties/:id/heating_systems/:id` | `owner/heating_systems#destroy` | Remove heating system |
| POST | `/owner/properties/:id/heating_systems/:id/heating_equipments` | `owner/heating_equipments#create` | Add heating equipment (AJAX) |
| DELETE | `/owner/properties/:id/heating_systems/:id/heating_equipments/:id` | `owner/heating_equipments#destroy` | Remove heating equipment (AJAX) |
| POST | `/owner/properties/:id/property_improvements` | `owner/property_improvements#create` | Add improvement/work record |
| PATCH | `/owner/properties/:id/property_improvements/:id` | `owner/property_improvements#update` | Update improvement record |
| DELETE | `/owner/properties/:id/property_improvements/:id` | `owner/property_improvements#destroy` | Remove improvement record |

### Application Management (Owner)

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/owner/applications` | `owner/applications#index` | List of all applications for owner's properties (grouped by property) |
| GET | `/owner/applications/:id` | `owner/applications#show` | View candidate details with multidimensional rating from admin |
| PATCH | `/owner/applications/:id/accept` | `owner/applications#accept` | Accept candidate (triggers lease generation) |
| PATCH | `/owner/applications/:id/reject` | `owner/applications#reject` | Reject candidate with optional reason |

### Lease Management (Owner)

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/owner/leases` | `owner/leases#index` | List of all leases (pending signature, signed, active, terminated) |
| GET | `/owner/leases/:id` | `owner/leases#show` | Lease details with status |
| GET | `/owner/leases/:id/preview` | `owner/leases#preview` | Preview generated lease PDF before signature |
| POST | `/owner/leases/:id/request_signature` | `owner/leases#request_signature` | Send lease for electronic signature (SignNow) |
| GET | `/owner/leases/:id/download` | `owner/leases#download` | Download signed lease PDF |

### Payment Management (Owner)

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/owner/payments` | `owner/payments#index` | Payment history for owner |
| GET | `/owner/payments/new?lease_id=:id` | `owner/payments#new` | Stripe payment form (zone-based pricing) |
| POST | `/owner/payments` | `owner/payments#create` | Process Stripe payment |
| GET | `/owner/payments/:id` | `owner/payments#show` | Payment details |
| GET | `/owner/payments/:id/success` | `owner/payments#success` | Payment success callback from Stripe |
| GET | `/owner/payments/:id/cancel` | `owner/payments#cancel` | Payment cancelled callback |

### Invoice Management (Owner)

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/owner/invoices` | `owner/invoices#index` | List of all invoices for owner |
| GET | `/owner/invoices/:id` | `owner/invoices#show` | Invoice details |
| GET | `/owner/invoices/:id/download` | `owner/invoices#download` | Download invoice PDF |

### Notifications (Owner)

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/owner/notifications` | `owner/notifications#index` | List of all notifications (new applications, signatures, etc.) |
| GET | `/owner/notifications/:id` | `owner/notifications#show` | Notification details |
| PATCH | `/owner/notifications/:id/mark_as_read` | `owner/notifications#mark_as_read` | Mark notification as read |

---

## Tenant Namespace

```ruby
namespace :tenant do
  root 'dashboard#index'
  
  # Dashboard
  resource :dashboard, only: [:index]
  
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
```

### Tenant Dashboard

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/tenant` | `tenant/dashboard#index` | Tenant dashboard: application status, document validation status, pending actions |

### Tenant Profile

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/tenant/profile` | `tenant/profile#show` | View tenant profile |
| GET | `/tenant/profile/edit` | `tenant/profile#edit` | Edit tenant profile form |
| PATCH | `/tenant/profile` | `tenant/profile#update` | Update tenant profile |
| GET | `/tenant/profile/documents` | `tenant/profile#documents` | Document upload page (ID, contract, pay slips, tax notice) |
| PATCH | `/tenant/profile/upload_documents` | `tenant/profile#upload_documents` | Upload/replace documents |

### Guarantor Management (Tenant)

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/tenant/guarantor` | `tenant/guarantor#show` | View guarantor information |
| GET | `/tenant/guarantor/new` | `tenant/guarantor#new` | Add guarantor form (physical person or Visale) |
| POST | `/tenant/guarantor` | `tenant/guarantor#create` | Create guarantor |
| GET | `/tenant/guarantor/edit` | `tenant/guarantor#edit` | Edit guarantor information |
| PATCH | `/tenant/guarantor` | `tenant/guarantor#update` | Update guarantor |
| DELETE | `/tenant/guarantor` | `tenant/guarantor#destroy` | Remove guarantor |

### Applications (Tenant)

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/tenant/applications` | `tenant/applications#index` | List of tenant's applications with status (pending, accepted, rejected) |
| GET | `/tenant/applications/:id` | `tenant/applications#show` | Application details with property info and status |
| PATCH | `/tenant/applications/:id/withdraw` | `tenant/applications#withdraw` | Withdraw application |

### Leases (Tenant)

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/tenant/leases` | `tenant/leases#index` | List of tenant's leases (pending signature, signed, active) |
| GET | `/tenant/leases/:id` | `tenant/leases#show` | Lease details |
| GET | `/tenant/leases/:id/preview` | `tenant/leases#preview` | Preview lease PDF before signing |
| POST | `/tenant/leases/:id/sign` | `tenant/leases#sign` | Sign lease electronically (SignNow) |
| GET | `/tenant/leases/:id/download` | `tenant/leases#download` | Download signed lease PDF |

### Rental CV (Tenant)

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/tenant/rental_cv` | `tenant/rental_cv#show` | View own rental CV (profile + documents + status) |
| GET | `/tenant/rental_cv/download` | `tenant/rental_cv#download` | Download rental CV as PDF |
| POST | `/tenant/rental_cv/generate_share_link` | `tenant/rental_cv#generate_share_link` | Generate unique shareable link for rental CV |

### Notifications (Tenant)

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| GET | `/tenant/notifications` | `tenant/notifications#index` | List of all notifications (application updates, signature requests) |
| GET | `/tenant/notifications/:id` | `tenant/notifications#show` | Notification details |
| PATCH | `/tenant/notifications/:id/mark_as_read` | `tenant/notifications#mark_as_read` | Mark notification as read |

---

## API Routes (Optional for future)

```ruby
namespace :api do
  namespace :v1 do
    # SignNow webhooks
    post '/webhooks/signnow', to: 'webhooks#signnow'
    
    # Stripe webhooks
    post '/webhooks/stripe', to: 'webhooks#stripe'
  end
end
```

| Method | Path | Controller#Action | Description |
|--------|------|-------------------|-------------|
| POST | `/api/v1/webhooks/signnow` | `api/v1/webhooks#signnow` | SignNow webhook for signature events |
| POST | `/api/v1/webhooks/stripe` | `api/v1/webhooks#stripe` | Stripe webhook for payment events |

---

## Route Constraints

### Authentication Requirements

```ruby
# Admin routes require admin role
authenticate :user, ->(user) { user.admin? } do
  namespace :admin do
    # admin routes
  end
end

# Owner routes require owner role
authenticate :user, ->(user) { user.owner? } do
  namespace :owner do
    # owner routes
  end
end

# Tenant routes require tenant role
authenticate :user, ->(user) { user.tenant? } do
  namespace :tenant do
    # tenant routes
  end
end
```

### Account Status Requirements

- **Owners**: Must have `status: validated` to access most features
- **Tenants**: Can access all features, but some actions require document validation
- **Admin**: Full access to all admin routes

---

## Redirects After Login

Based on user role:
- **Admin** → `/admin` (dashboard)
- **Owner** → `/owner` (dashboard)
- **Tenant** → `/tenant` (dashboard)

Based on account status:
- **Owner (pending)** → `/owner/profile` (with message to wait for validation)
- **Owner (rejected)** → `/owner/profile` (with rejection reason)

---

## Error Pages

| Path | Description |
|------|-------------|
| `/404` | Page not found |
| `/422` | Unprocessable entity |
| `/500` | Internal server error |

---

## Notes

1. **Namespacing**: All authenticated routes are namespaced by role (admin, owner, tenant) for clear separation of concerns and easier authorization management.

2. **Wizard Pattern**: Property creation uses a multi-step wizard pattern with separate actions for each step.

3. **AJAX Routes**: Many nested resource routes (equipments, amenities, etc.) are designed for AJAX calls to provide a smooth UX.

4. **RESTful Design**: Routes follow Rails RESTful conventions with member and collection routes where appropriate.

5. **Security**: All routes require authentication and role-based authorization. Devise handles authentication, and Pundit (or similar) should handle authorization.

6. **Webhooks**: Separate API namespace for external service webhooks (SignNow, Stripe).

7. **Download Routes**: Separate download actions for PDFs (leases, invoices, rental CVs) to handle proper content disposition.

8. **Turbo/Hotwire**: Many routes can benefit from Turbo Frames and Streams for dynamic updates without full page reloads.

9. **Breadcrumbs**: Implement breadcrumbs for complex nested routes (especially in owner property wizard).

10. **Mobile Responsive**: All routes should render mobile-responsive views using Tailwind CSS.
