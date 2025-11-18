# Mockup Specifications - OLAK Platform

## Overview

This document describes the mockup system implemented in the OLAK application. The mockup namespace provides static views to demonstrate user journeys, interface designs, and user flows before implementing the actual functionality.

**IMPORTANT**: All mockups MUST follow the OLAK Design System documented in `doc/design_system.md`

## Purpose

The mockup system serves several purposes:

1. **Visual Design Validation**: Allow stakeholders to see and validate UI/UX before development
2. **User Flow Testing**: Demonstrate complete user journeys through the application
3. **Development Reference**: Provide a visual reference for developers implementing features
4. **Client Feedback**: Enable early feedback on design and functionality
5. **Documentation**: Serve as living documentation of intended features

## Design System Reference

**READ FIRST**: `doc/design_system.md`

All mockups must use:
- OLAK color palette (primary: #9C8671, etc.)
- OLAK typography (Inter font, defined scales)
- OLAK components (buttons, cards, forms, badges)
- OLAK logo (`app/assets/images/logo_olak.png`)
- OLAK spacing system (8px base)
- OLAK icons (Material Design style)

**Never create custom styles that deviate from the design system without approval.**

## Architecture

### Namespace Structure

```
mockups/
├── controller: MockupsController
├── routes: All prefixed with /mockups/
├── views: app/views/mockups/
└── layouts: 
    ├── mockup_admin.html.erb (Purple accents)
    ├── mockup_owner.html.erb (Blue accents)
    └── mockup_tenant.html.erb (Green accents)
```

### Layout Strategy

The mockup system uses dynamic layout resolution based on the action name:

- **Index page**: Uses `application` layout
- **Admin pages** (`admin_*`): Uses `mockup_admin` layout with purple theme
- **Owner pages** (`owner_*`): Uses `mockup_owner` layout with blue theme
- **Tenant pages** (`tenant_*`): Uses `mockup_tenant` layout with green theme
- **Public page** (`public_landing`): Uses `application` layout

## Mockup Index Page

**Route**: `/mockups` or `/mockups/index`

**Purpose**: Central hub showing all available user journeys

**Content**:
- OLAK logo at top
- Overview of available mockup journeys
- Journey cards for each user type (Admin, Owner, Tenant, Public)
- Links to start each journey
- Brief description of each journey
- Legend/key for mockup annotations

**Layout Structure**:
```erb
<div class="mockup-index max-w-7xl mx-auto px-6 py-12">
  <div class="text-center mb-12">
    <%= image_tag 'logo_olak.png', alt: 'OLAK', class: 'h-16 mx-auto mb-4' %>
    <h1 class="text-5xl font-bold text-olak-primary-dark">Mockup Journey Explorer</h1>
    <p class="text-gray-600 mt-4">Explorez les parcours utilisateurs de la plateforme OLAK</p>
  </div>
  
  <!-- Journey Cards -->
  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-12">
    <%= render 'journey_card', 
               title: 'Admin',
               color: 'purple',
               icon: 'admin',
               routes: @admin_routes %>
    
    <%= render 'journey_card',
               title: 'Propriétaire', 
               color: 'blue',
               icon: 'owner',
               routes: @owner_routes %>
    
    <%= render 'journey_card',
               title: 'Locataire',
               color: 'green',
               icon: 'tenant',
               routes: @tenant_routes %>
    
    <%= render 'journey_card',
               title: 'Public',
               color: 'gray',
               icon: 'public',
               route: @public_route %>
  </div>
  
  <!-- Legend -->
  <%= render 'mockup_legend' %>
</div>
```

## User Journeys to Implement

### 1. Public Journey

#### Landing Page (One-Pager)
- **Route**: `/mockups/public_landing`
- **Purpose**: Show OLAK announcement page (bonus feature)
- **Design System Requirements**:
  - Use OLAK logo prominently
  - Primary color for CTAs
  - Card components for feature sections
  - Responsive grid layout
- **Elements**:
  - Hero section with logo and value proposition
  - Brief feature overview (3-4 key features in cards)
  - Call-to-action (contact information)
  - Minimal single-page design
  - Footer with OLAK branding
  - No registration links (handled by admin)

**Note**: This is the ONLY public page. Tenant registration is done via unique links sent by admin, and rental CV sharing is via unique tokens (both are authenticated flows, not truly "public").

---

### 2. Admin Journey

**Theme**: Purple accents (use design system purple variants for admin-specific elements)

#### Admin Dashboard
- **Route**: `/mockups/admin_dashboard`
- **Purpose**: Main admin control center
- **Design System Requirements**:
  - Use card components for metrics
  - Primary color for action buttons
  - Success/Warning/Error badges for status
  - Chart placeholders with OLAK colors
- **Elements**:
  - Key metrics cards (pending validations, active properties, applications)
  - Recent activity feed
  - Quick actions panel
  - Charts/graphs (monthly revenue, properties by status)
  - Alerts/notifications

#### Owner Management
- **Route**: `/mockups/admin_owners_list`
- **Purpose**: List and manage owner accounts
- **Design System Requirements**:
  - Table component with OLAK styling
  - Badge components for status
  - Primary buttons for actions
- **Elements**:
  - Owner list table with filters (pending, validated, rejected)
  - Search functionality
  - Status badges (use design system badge classes)
  - Action buttons (validate, reject, view details)
  - Pagination

- **Route**: `/mockups/admin_owner_detail`
- **Purpose**: View individual owner details
- **Design System Requirements**:
  - Card layout for sections
  - Document viewer component
  - Form inputs for validation
- **Elements**:
  - Owner profile information
  - Uploaded documents viewer
  - Properties owned
  - Validation form with comments
  - Action buttons (validate, reject, edit)

- **Route**: `/mockups/admin_owner_create`
- **Purpose**: Manually create owner account
- **Design System Requirements**:
  - Multi-step wizard component
  - Form inputs (design system)
  - File upload component
- **Elements**:
  - Multi-step form (Personal info, Company info if applicable)
  - Document upload placeholders
  - Save as draft option
  - Validation rules display

#### Tenant Management
- **Route**: `/mockups/admin_tenants_list`
- **Purpose**: List all tenant candidates
- **Design System Requirements**:
  - Table with status badges
  - Quick action buttons
- **Elements**:
  - Tenant list with status filters
  - Document validation status
  - Application count per tenant
  - Quick validation actions

- **Route**: `/mockups/admin_tenant_detail`
- **Purpose**: View tenant profile and documents
- **Design System Requirements**:
  - Card sections
  - Document viewer
  - Notes textarea
- **Elements**:
  - Profile information
  - Document viewer/validator
  - Application history
  - Ratings given
  - Notes section

#### Property Management
- **Route**: `/mockups/admin_properties_list`
- **Purpose**: Overview of all properties
- **Design System Requirements**:
  - Property cards using card-olak class
  - Filter components
- **Elements**:
  - Property cards/list
  - Filters (type, status, owner, zone)
  - Property details preview
  - Application count per property

- **Route**: `/mockups/admin_property_detail`
- **Purpose**: View property details
- **Design System Requirements**:
  - Sectioned card layout
  - Document viewer
- **Elements**:
  - Property information
  - Document viewer
  - Applications for this property
  - Owner information
  - Map placeholder (excluded from MVP but show space reserved)

#### Application & Rating Management
- **Route**: `/mockups/admin_applications_list`
- **Purpose**: Manage all rental applications
- **Design System Requirements**:
  - Table or card grid
  - Status badges
  - Action buttons
- **Elements**:
  - Application list with filters
  - Property and tenant quick view
  - Rating status
  - Actions (rate, propose to owner)

- **Route**: `/mockups/admin_rating_form`
- **Purpose**: Rate tenant candidate
- **Design System Requirements**:
  - Star rating component (design system)
  - Overall score display
  - Form layout
- **Elements**:
  - Multidimensional rating interface:
    - Salary/rent ratio (1-5 stars)
    - Contract type (1-5 stars)
    - Guarantors (1-5 stars)
    - Contract duration (1-5 stars)
    - Agent feeling (1-5 stars)
  - Overall score calculation (automatic)
  - Notes textarea
  - Submit button (triggers proposal to owner)

#### Visit Calendar
- **Route**: `/mockups/admin_visits_calendar`
- **Purpose**: Manage visit appointments
- **Design System Requirements**:
  - Calendar grid layout
  - Card components for visits
  - Color coding with OLAK palette
- **Elements**:
  - Calendar view (day/week/month)
  - Visit cards with property and tenant info
  - Add visit button
  - Drag-and-drop rescheduling (visual only)
  - Color coding by property

- **Route**: `/mockups/admin_visit_form`
- **Purpose**: Schedule/edit visit
- **Design System Requirements**:
  - Form inputs (design system)
  - Date picker component
- **Elements**:
  - Date/time picker
  - Property selector
  - Tenant selector
  - Location details
  - Notes field
  - Email notification checkbox

#### Payment Dashboard
- **Route**: `/mockups/admin_payments_dashboard`
- **Purpose**: Financial overview
- **Design System Requirements**:
  - Chart components with OLAK colors
  - Metric cards
  - Table component
- **Elements**:
  - Revenue charts (monthly, yearly)
  - Payment list with filters
  - Zone-based pricing breakdown
  - Export button
  - Payment status indicators

- **Route**: `/mockups/admin_payments_list`
- **Purpose**: Detailed payment list
- **Design System Requirements**:
  - Table with sorting
  - Badge components
- **Elements**:
  - Payment table (date, owner, amount, status, zone)
  - Search and filters
  - Invoice links
  - Refund actions (if applicable)

#### Invoice Management
- **Route**: `/mockups/admin_invoices_list`
- **Purpose**: List all invoices
- **Design System Requirements**:
  - Table component
  - Primary button for creation
- **Elements**:
  - Invoice table with search
  - Download buttons
  - Manual invoice creation button
  - Status filters

- **Route**: `/mockups/admin_invoice_create`
- **Purpose**: Manually generate invoice
- **Design System Requirements**:
  - Form layout (2-column grid)
  - Preview pane
- **Elements**:
  - Owner selector
  - Amount input
  - Service description
  - Date picker
  - Generate button
  - Preview pane

#### Accounting Export
- **Route**: `/mockups/admin_accounting_export`
- **Purpose**: Export accounting data
- **Design System Requirements**:
  - Form inputs
  - Table for history
- **Elements**:
  - Date range selector
  - Export format options (CSV, Excel)
  - Export history
  - Download buttons

---

### 3. Owner Journey

**Theme**: Blue accents (use design system blue variants for owner-specific elements)

#### Owner Dashboard
- **Route**: `/mockups/owner_dashboard`
- **Purpose**: Owner home page
- **Design System Requirements**:
  - Card grid for properties
  - Alert component for validation status
  - Metric cards
- **Elements**:
  - Properties overview (active, rented, drafts)
  - Pending applications notification
  - Recent activities
  - Quick actions (add property, view applications)
  - Validation status banner (if pending)

#### Owner Profile
- **Route**: `/mockups/owner_profile_show`
- **Purpose**: View owner profile
- **Design System Requirements**:
  - Card layout for sections
  - Badge for validation status
- **Elements**:
  - Profile information display
  - Documents uploaded
  - Co-owner information (if applicable)
  - Edit button
  - Validation status

- **Route**: `/mockups/owner_profile_edit`
- **Purpose**: Edit owner profile
- **Design System Requirements**:
  - Form grid (2-column)
  - Input components
  - File upload component
- **Elements**:
  - Form with all profile fields
  - Document upload/replace
  - Co-owner management
  - Warning alert that changes require re-validation
  - Save button

#### Property Creation Wizard

##### Step 1: Property Type Selection
- **Route**: `/mockups/owner_property_step1`
- **Purpose**: Choose what to rent
- **Design System Requirements**:
  - Three large card components
  - Icons (house, building, room)
  - Wizard stepper component
- **Elements**:
  - Step indicator (1 of 3)
  - Three large option cards:
    - "Appartement entier"
    - "Maison entière"
    - "Une Chambre"
  - Visual icons for each option
  - Next button (primary)

##### Step 2: Property Details Form
- **Route**: `/mockups/owner_property_step2_apartment`
- **Purpose**: Apartment details form
- **Design System Requirements**:
  - Form grid layout
  - Input components
  - Repeatable field interface
  - Alert for zone tendue
  - File upload components
- **Elements**:
  - Step indicator (2 of 3)
  - Address fields with zone tendue indicator (warning alert if detected)
  - Rental type selector (Meublé/Nue) - radio buttons
  - Surface area
  - Room counts
  - Equipment checkboxes (repeatable interface)
  - Amenities (repeatable interface)
  - Document upload sections
  - Rent information with automatic calculations display
  - Navigation: Save draft (secondary) / Next (primary)

- **Route**: `/mockups/owner_property_step2_house`
- **Purpose**: House details form
- **Design System Requirements**:
  - Same as apartment
- **Elements**:
  - Similar to apartment but with house-specific fields
  - Land surface area
  - Levels count
  - No building section needed

- **Route**: `/mockups/owner_property_step2_room`
- **Purpose**: Room container selection (Apartment or House)
- **Design System Requirements**:
  - Radio button selection
  - Conditional form display
- **Elements**:
  - Step indicator (2 of 3)
  - Choice between "Dans un appartement" / "Dans une maison" (radio)
  - Then renders appropriate form
  - Additional room-specific fields

##### Step 3: Building/Additional Details
- **Route**: `/mockups/owner_property_step3_building`
- **Purpose**: Building details (for apartments)
- **Design System Requirements**:
  - Form components
  - Checkbox groups
- **Elements**:
  - Step indicator (3 of 3)
  - Building type
  - Construction year
  - Floors count
  - Common amenities (checkboxes)
  - Entry code
  - Navigation: Back (secondary) / Publish (primary)

- **Route**: `/mockups/owner_property_step3_room`
- **Purpose**: Individual room details
- **Design System Requirements**:
  - Form inputs
  - Conditional checkboxes
  - Calculation display
- **Elements**:
  - Step indicator (3 of 3)
  - Room number/description
  - Private surface area
  - Private bathroom checkbox with sub-fields (conditional)
  - Room rent calculation display (with remaining rent if zone tendue)
  - Navigation: Back (secondary) / Publish (primary)

#### Property Management
- **Route**: `/mockups/owner_properties_list`
- **Purpose**: List owner's properties
- **Design System Requirements**:
  - Card grid layout
  - Filter component
  - Status badges
- **Elements**:
  - Property cards with status badges
  - Filters (draft, active, rented, archived)
  - Add property button (primary, large)
  - Quick actions (edit, view, archive)

- **Route**: `/mockups/owner_property_show`
- **Purpose**: View property details
- **Design System Requirements**:
  - Sectioned card layout
  - Document viewer
  - Action buttons
- **Elements**:
  - Complete property information
  - Documents viewer
  - Applications for this property
  - Edit/Archive buttons
  - Publish button (if draft)

#### Repeatable Fields Examples
- **Route**: `/mockups/owner_equipment_interface`
- **Purpose**: Demonstrate repeatable field pattern
- **Design System Requirements**:
  - Add/remove buttons
  - List items with delete icons
  - Nested repeatable example
- **Elements**:
  - "Ajouter un équipement" button (primary)
  - Equipment list with remove buttons
  - Example for heating systems with nested equipment
  - Example for improvements/works

#### Application Management
- **Route**: `/mockups/owner_applications_list`
- **Purpose**: View candidates proposed by admin
- **Design System Requirements**:
  - Card grid grouped by property
  - Rating display component
  - Action buttons
- **Elements**:
  - Application cards grouped by property
  - Candidate information preview
  - Multidimensional rating display (5 stars + overall score)
  - Accept (primary) / Reject (secondary) buttons
  - View full candidate profile link

- **Route**: `/mockups/owner_application_detail`
- **Purpose**: View candidate full profile
- **Design System Requirements**:
  - Card sections
  - Rating breakdown component
  - Document viewer
  - Confirmation modal
- **Elements**:
  - Candidate personal info
  - Employment details
  - Guarantor information
  - Rating breakdown with visual indicators
  - Documents viewer
  - Accept/Reject buttons with confirmation modal

#### Lease Management
- **Route**: `/mockups/owner_leases_list`
- **Purpose**: List all leases
- **Design System Requirements**:
  - Card or table layout
  - Status badges
- **Elements**:
  - Lease cards with status
  - Filters by status
  - Signing status indicators
  - Download buttons

- **Route**: `/mockups/owner_lease_show`
- **Purpose**: View lease details
- **Design System Requirements**:
  - Card sections
  - Status timeline
  - Action buttons
- **Elements**:
  - Lease information
  - Property details
  - Tenant details
  - Signature status (owner signed, tenant pending, both signed)
  - Preview button (secondary)
  - Download button (primary, if signed)

- **Route**: `/mockups/owner_lease_preview`
- **Purpose**: Preview generated lease PDF
- **Design System Requirements**:
  - PDF viewer frame
  - Action bar with buttons
- **Elements**:
  - PDF preview iframe/viewer
  - Lease type badge (Nue/Meublé/Chambre)
  - Request signature button (primary)
  - Edit property details link (if not signed yet)

#### Payment Management
- **Route**: `/mockups/owner_payment_form`
- **Purpose**: Stripe payment page
- **Design System Requirements**:
  - Card container
  - Form inputs
  - Info alerts for pricing
- **Elements**:
  - Amount display card (zone-based pricing)
  - Lease information summary
  - Stripe payment form (card input mockup)
  - Terms acceptance checkbox
  - Pay button (primary, large)

- **Route**: `/mockups/owner_payment_success`
- **Purpose**: Payment confirmation
- **Design System Requirements**:
  - Success alert component
  - Card for details
  - Primary action button
- **Elements**:
  - Success alert/message
  - Payment details card
  - Invoice download link
  - Next steps information

- **Route**: `/mockups/owner_payments_list`
- **Purpose**: Payment history
- **Design System Requirements**:
  - Table component
  - Badge for status
  - Download links
- **Elements**:
  - Payment table with filters
  - Invoice download links
  - Payment status badges

#### Invoice Management
- **Route**: `/mockups/owner_invoices_list`
- **Purpose**: View all invoices
- **Design System Requirements**:
  - Table layout
  - Action buttons
- **Elements**:
  - Invoice list with dates
  - Amount and status
  - Download buttons
  - Search/filter

#### Notifications
- **Route**: `/mockups/owner_notifications`
- **Purpose**: Notification center
- **Design System Requirements**:
  - List items with hover states
  - Badge for unread
  - Icon for notification type
- **Elements**:
  - Notification list (new applications, signatures, etc.)
  - Read/unread indicators
  - Mark as read buttons
  - Filter options

---

### 4. Tenant Journey

**Theme**: Green accents (use design system green variants for tenant-specific elements)

#### Tenant Dashboard
- **Route**: `/mockups/tenant_dashboard`
- **Purpose**: Tenant home page
- **Design System Requirements**:
  - Card grid for overview
  - Alert for pending actions
  - Quick action buttons
- **Elements**:
  - Application status overview
  - Document validation status
  - Pending actions alerts
  - Quick links (upload documents, view applications)

#### Tenant Profile
- **Route**: `/mockups/tenant_profile_show`
- **Purpose**: View tenant profile
- **Design System Requirements**:
  - Card sections
  - Edit button
- **Elements**:
  - Personal information
  - Employment details
  - Edit button (primary)

- **Route**: `/mockups/tenant_profile_edit`
- **Purpose**: Edit tenant profile
- **Design System Requirements**:
  - Form grid (2-column)
  - Input components
- **Elements**:
  - Personal info form
  - Employment info form
  - Navigation: Cancel (secondary) / Save (primary)

#### Document Upload
- **Route**: `/mockups/tenant_documents`
- **Purpose**: Upload required documents
- **Design System Requirements**:
  - File upload component (drag & drop)
  - Checklist with status indicators
  - Document preview
- **Elements**:
  - Document checklist with status badges:
    - Identity card (required)
    - Employment contract (required)
    - 3 pay slips (required)
    - Tax notice (required)
  - Upload buttons for each document (file upload component)
  - Preview/replace options
  - Validation status from admin
  - Help text for each document (info alerts)

#### Guarantor Management
- **Route**: `/mockups/tenant_guarantor_form`
- **Purpose**: Add/edit guarantor
- **Design System Requirements**:
  - Radio button selection
  - Conditional form display
  - File upload component
- **Elements**:
  - Guarantor type selector (Physical person / Visale) - radio
  - Physical person form (similar to tenant profile)
  - Visale form (number and date)
  - Document upload (if physical person)
  - Save button (primary)

- **Route**: `/mockups/tenant_guarantor_show`
- **Purpose**: View guarantor details
- **Design System Requirements**:
  - Card layout
  - Action buttons
- **Elements**:
  - Guarantor information
  - Documents (if physical person)
  - Edit (secondary) / Remove (danger) buttons

#### Applications
- **Route**: `/mockups/tenant_applications_list`
- **Purpose**: View application status
- **Design System Requirements**:
  - Card grid
  - Status badges with timeline
  - Action buttons
- **Elements**:
  - Application cards with property info
  - Status badges (pending, proposed, accepted, rejected)
  - Withdraw button (if pending)
  - Property details link

- **Route**: `/mockups/tenant_application_show`
- **Purpose**: View application details
- **Design System Requirements**:
  - Card sections
  - Timeline component
  - Info alerts
- **Elements**:
  - Property information card
  - Application date
  - Status timeline with visual indicators
  - Owner decision (if any)
  - Next steps information (alert)

#### Lease Management
- **Route**: `/mockups/tenant_leases_list`
- **Purpose**: View tenant leases
- **Design System Requirements**:
  - Card grid
  - Status badges
  - Action buttons
- **Elements**:
  - Lease cards with status
  - Signature status
  - Preview/download buttons

- **Route**: `/mockups/tenant_lease_show`
- **Purpose**: View lease details
- **Design System Requirements**:
  - Card sections
  - Status indicators
  - Action buttons
- **Elements**:
  - Lease information
  - Property details
  - Signature status (with visual indicator)
  - Preview button (secondary)
  - Sign button (primary, if pending signature)
  - Download button (primary, if signed)

- **Route**: `/mockups/tenant_lease_preview`
- **Purpose**: Preview lease before signing
- **Design System Requirements**:
  - PDF viewer frame
  - Action bar
  - Highlighted terms
- **Elements**:
  - PDF preview
  - Key terms highlighted
  - Sign button (primary, large)
  - Questions/contact link

#### Rental CV
- **Route**: `/mockups/tenant_rental_cv`
- **Purpose**: View and manage rental CV
- **Design System Requirements**:
  - Professional card layout
  - Status indicators
  - Action buttons
  - Copy-to-clipboard component
- **Elements**:
  - CV preview (professional presentation)
  - Document completion status (progress bar)
  - Download as PDF button (secondary)
  - Generate share link button (primary)
  - Share link display (if generated) with copy button
  - Copy link button

#### Notifications
- **Route**: `/mockups/tenant_notifications`
- **Purpose**: Notification center
- **Design System Requirements**:
  - List with hover states
  - Unread badges
  - Icons for notification types
- **Elements**:
  - Notification list (application updates, signature requests)
  - Read/unread indicators
  - Mark as read buttons
  - Filter options

---

## UI Components & Patterns

**IMPORTANT**: All components listed below MUST use the OLAK Design System classes and patterns defined in `doc/design_system.md`

### Common Components to Mockup

#### 1. Navigation
- **Top navbar** with OLAK logo and role-specific menu items
- **Breadcrumbs** for nested pages (design system breadcrumb component)
- **User dropdown** with profile/logout

#### 2. Forms
- **Text inputs** with labels and help text (`.input-olak`)
- **Select dropdowns** (single and multiple)
- **Radio buttons** (for slash-separated choices)
- **Checkboxes** (for comma-separated choices)
- **File upload** interface with drag-and-drop (design system component)
- **Date pickers**
- **Repeatable field** interface (Add/Remove buttons)

#### 3. Data Display
- **Tables** with sorting and filtering (design system table)
- **Cards** for overview data (`.card-olak`)
- **Lists** with action buttons
- **Status badges** with color coding (`.badge-*`)
- **Progress indicators**
- **Timeline/stepper** for multi-step processes

#### 4. Actions
- **Primary buttons** (`.btn-primary`)
- **Secondary buttons** (`.btn-secondary`)
- **Danger buttons** (delete, reject)
- **Icon buttons** for quick actions (Material Design icons)
- **Dropdown menus** for multiple actions

#### 5. Feedback
- **Alert banners** (success, error, warning, info) - design system alerts
- **Toasts/notifications** (temporary messages)
- **Loading states** (spinners, skeleton screens) - design system
- **Empty states** (no data messages) - design system
- **Confirmation modals** - design system modal

#### 6. Rating Display
- **Star rating** component (1-5 stars) - design system
- **Score display** with visual indicator (progress bar/circle)
- **Multidimensional rating** grid/cards

---

## Mockup Annotations

### Visual Indicators

To help distinguish mockups from real functionality, use:

1. **Mockup Badge**: Display "MOCKUP" badge in corner of each page (yellow badge as per design system)
2. **Dummy Data Labels**: Label obviously fake data with "(Example)"
3. **Non-functional Warnings**: Tooltips on buttons saying "Mockup only - not functional"
4. **Placeholder Images**: Use distinct placeholder images/icons
5. **Colored Borders**: Optional colored border around mockup pages

### Annotation Component

```erb
<!-- app/views/mockups/_mockup_badge.html.erb -->
<div class="fixed top-4 right-4 bg-yellow-400 text-black px-3 py-1 rounded-full shadow-lg z-50 font-bold text-sm">
  🎨 MOCKUP
</div>
```

---

## Implementation Guidelines

### Before Starting

1. **Read** `doc/design_system.md` completely
2. **Setup** CSS variables and Tailwind config
3. **Add** OLAK logo to assets
4. **Create** component partials from design system
5. **Test** design system components in isolation

### Controller Structure

```ruby
# app/controllers/mockups_controller.rb
class MockupsController < ApplicationController
  layout :resolve_layout
  
  # Skip authentication for mockups
  skip_before_action :authenticate_user!, if: -> { Rails.env.development? }
  
  def index
    @admin_routes = admin_mockup_routes
    @owner_routes = owner_mockup_routes
    @tenant_routes = tenant_mockup_routes
    @public_route = public_mockup_route
  end
  
  # Public page (one-pager only)
  def public_landing; end
  
  # Admin pages (15 pages)
  def admin_dashboard; end
  def admin_owners_list; end
  def admin_owner_detail; end
  def admin_owner_create; end
  def admin_tenants_list; end
  def admin_tenant_detail; end
  def admin_properties_list; end
  def admin_property_detail; end
  def admin_applications_list; end
  def admin_rating_form; end
  def admin_visits_calendar; end
  def admin_visit_form; end
  def admin_payments_dashboard; end
  def admin_payments_list; end
  def admin_invoices_list; end
  def admin_invoice_create; end
  def admin_accounting_export; end
  
  # Owner pages (20 pages)
  def owner_dashboard; end
  def owner_profile_show; end
  def owner_profile_edit; end
  def owner_property_step1; end
  def owner_property_step2_apartment; end
  def owner_property_step2_house; end
  def owner_property_step2_room; end
  def owner_property_step3_building; end
  def owner_property_step3_room; end
  def owner_equipment_interface; end
  def owner_properties_list; end
  def owner_property_show; end
  def owner_applications_list; end
  def owner_application_detail; end
  def owner_leases_list; end
  def owner_lease_show; end
  def owner_lease_preview; end
  def owner_payment_form; end
  def owner_payment_success; end
  def owner_payments_list; end
  def owner_invoices_list; end
  def owner_notifications; end
  
  # Tenant pages (13 pages)
  def tenant_dashboard; end
  def tenant_profile_show; end
  def tenant_profile_edit; end
  def tenant_documents; end
  def tenant_guarantor_form; end
  def tenant_guarantor_show; end
  def tenant_applications_list; end
  def tenant_application_show; end
  def tenant_leases_list; end
  def tenant_lease_show; end
  def tenant_lease_preview; end
  def tenant_rental_cv; end
  def tenant_notifications; end
  
  private
  
  def resolve_layout
    case action_name
    when 'index'
      'application'
    when 'public_landing'
      'application'
    when /^admin_/
      'mockup_admin'
    when /^owner_/
      'mockup_owner'
    when /^tenant_/
      'mockup_tenant'
    else
      'application'
    end
  end
  
  def admin_mockup_routes
    # Return array of admin route hashes for index page
    [
      { name: 'Dashboard', path: mockups_admin_dashboard_path },
      { name: 'Gestion Propriétaires', path: mockups_admin_owners_list_path },
      # etc...
    ]
  end
  
  def owner_mockup_routes
    # Return array of owner route hashes for index page
  end
  
  def tenant_mockup_routes
    # Return array of tenant route hashes for index page
  end
  
  def public_mockup_route
    # Return single public route hash
    { name: 'Page d\'accueil', path: mockups_landing_path }
  end
end
```

### Routes Configuration

```ruby
# config/routes.rb
namespace :mockups do
  root to: 'mockups#index'
  
  # Public (one-pager only)
  get 'landing', to: 'mockups#public_landing'
  
  # Admin
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
  
  # Owner
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
  
  # Tenant
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
```

### Layouts

Create three role-specific layouts following design system:

#### 1. mockup_admin.html.erb
- **Theme**: Purple accents for admin-specific elements
- **Logo**: OLAK logo in navbar
- **Navigation**: Admin menu items with active states
- **User dropdown**: Mock admin user
- **Mockup badge**: Include annotation component

#### 2. mockup_owner.html.erb
- **Theme**: Blue accents for owner-specific elements
- **Logo**: OLAK logo in navbar
- **Navigation**: Owner menu items with active states
- **User dropdown**: Mock owner user
- **Mockup badge**: Include annotation component

#### 3. mockup_tenant.html.erb
- **Theme**: Green accents for tenant-specific elements
- **Logo**: OLAK logo in navbar
- **Navigation**: Tenant menu items with active states
- **User dropdown**: Mock tenant user
- **Mockup badge**: Include annotation component

**All layouts must include**:
- Design system CSS variables
- OLAK logo
- Role-specific color theme
- Mockup badge
- Breadcrumbs component
- Responsive design

---

## Data Strategy

### Dummy Data

Use realistic but obviously fake data from `MockupData` module:

- **Names**: Jean Dupont, Marie Martin, Pierre Bernard
- **Emails**: proprietaire@example.olak.fr, locataire@example.olak.fr
- **Addresses**: 123 Rue de la Paix, 75002 Paris
- **Phone**: 06 12 34 56 78
- **Dates**: Recent but clearly examples
- **Amounts**: Round numbers (€1000, €500)

### Sample Data Module

```ruby
# app/models/concerns/mockup_data.rb
module MockupData
  def self.sample_owner
    {
      first_name: "Jean",
      last_name: "Dupont",
      email: "jean.dupont@example.olak.fr",
      phone: "06 12 34 56 78",
      address: "123 Rue de la Paix, 75002 Paris",
      status: "validated"
    }
  end
  
  def self.sample_property
    {
      property_type: "Appartement",
      rental_type: "Meublé",
      address: "45 Avenue des Champs-Élysées, 75008 Paris",
      surface_area: 65,
      rooms: 3,
      rent: 1500,
      charges: 150,
      total_rent: 1650,
      deposit: 3000,
      status: "active",
      zone_tendue: true
    }
  end
  
  def self.sample_tenant
    {
      first_name: "Marie",
      last_name: "Martin",
      email: "marie.martin@example.olak.fr",
      phone: "06 98 76 54 32",
      employment_status: "CDI",
      monthly_salary: 2500,
      status: "pending"
    }
  end
  
  def self.sample_rating
    {
      salary_ratio: 4,
      contract_type: 5,
      guarantors: 4,
      duration: 5,
      agent_feeling: 4,
      overall: 4.4
    }
  end
  
  # Add more sample data methods...
end
```

---

## Deliverables Checklist

### Phase 0: Design System Setup
- [ ] Read and understand `doc/design_system.md`
- [ ] Add CSS variables to `application.tailwind.css`
- [ ] Configure Tailwind with OLAK colors
- [ ] Add OLAK logo to `app/assets/images/logo_olak.png`
- [ ] Create component partials (buttons, cards, forms, badges, alerts)
- [ ] Test design system components

### Phase 1: Core Structure
- [ ] MockupsController created with all actions
- [ ] Routes configured
- [ ] Three role-specific layouts created (with design system)
- [ ] Index page with journey cards (using design system)
- [ ] Mockup badge component
- [ ] Navigation partials for each role (with OLAK logo)

### Phase 2: Public & Admin Journeys
- [ ] Public landing page (one-pager with OLAK design)
- [ ] Admin dashboard
- [ ] Admin owner management (list, detail, create)
- [ ] Admin tenant management (list, detail)
- [ ] Admin properties (list, detail)
- [ ] Admin applications & rating
- [ ] Admin visit calendar
- [ ] Admin payment dashboard
- [ ] Admin invoice management
- [ ] Admin accounting export

### Phase 3: Owner Journey
- [ ] Owner dashboard
- [ ] Owner profile (show, edit)
- [ ] Property wizard step 1
- [ ] Property wizard step 2 (all variants)
- [ ] Property wizard step 3 (all variants)
- [ ] Repeatable fields interface
- [ ] Owner properties list
- [ ] Owner property detail
- [ ] Owner applications (list, detail)
- [ ] Owner lease management
- [ ] Owner payment flow
- [ ] Owner invoices
- [ ] Owner notifications

### Phase 4: Tenant Journey
- [ ] Tenant dashboard
- [ ] Tenant profile (show, edit)
- [ ] Tenant document upload
- [ ] Tenant guarantor management
- [ ] Tenant applications (list, show)
- [ ] Tenant lease management
- [ ] Tenant rental CV
- [ ] Tenant notifications

### Phase 5: Polish & Refinement
- [ ] Verify design system compliance on all pages
- [ ] Responsive design verification (mobile, tablet, desktop)
- [ ] Annotation and help text
- [ ] Inter-page navigation links
- [ ] Dummy data consistency
- [ ] Loading states (design system)
- [ ] Empty states (design system)
- [ ] Error state examples (design system)

---

## Usage Guidelines

### For Developers

1. **Design System First**: Always check `doc/design_system.md` before creating mockups
2. **Use Components**: Leverage design system components, don't recreate
3. **Match Layout**: Use mockup as visual reference for styling
4. **Component Extraction**: Identify reusable components from mockups
5. **Data Structure**: Note data fields and relationships shown in mockups

### For Designers

1. **Follow Design System**: All design decisions must align with design system
2. **Iterate in Mockups**: Make design changes in mockups first
3. **Test Flows**: Verify user flows by clicking through mockups
4. **Get Feedback**: Share mockup URLs for stakeholder review
5. **Document Changes**: Update design system if patterns change

### For Product Owners

1. **Validate Features**: Review mockups before development starts
2. **Provide Feedback**: Comment on mockup pages early
3. **Test Journeys**: Walk through complete user journeys
4. **Approve Designs**: Sign off on mockups before implementation

---

## Notes

1. **Design System Compliance**: All mockups MUST use design system components and styles
2. **Logo Usage**: Always use official OLAK logo from assets
3. **No Backend Logic**: Mockups are purely visual, no database interactions
4. **Static Data**: All data is hardcoded using MockupData module
5. **Navigation Only**: Links between mockup pages work, forms don't submit
6. **Responsive Design**: All mockups must work on mobile/tablet/desktop
7. **Accessibility**: Follow WCAG AA standards as defined in design system
8. **Performance**: Keep mockups fast-loading (optimize images)
9. **Version Control**: Commit mockups separately from real features
10. **Documentation**: Update this spec when adding new mockup pages
11. **Public Access**: Only ONE public page (landing page)

---

## Future Enhancements

- [ ] Add mockup tour/walkthrough overlay
- [ ] Screenshot generation for documentation
- [ ] Interactive prototype features (form validation mockups)
- [ ] A/B testing different layouts
- [ ] Export mockups as static HTML for sharing
- [ ] Add annotations and comments directly on mockup pages
- [ ] Version history of mockup changes
- [ ] Design system component library showcase page
