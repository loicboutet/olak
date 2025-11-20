# Owner Lease Management - Implementation Plan

## Overview
This document outlines the implementation plan for the Owner Lease Management feature as specified in `doc/mockup_specifications.md` (lines 566-602).

## Routes (Already Defined)
From `config/routes.rb` (lines 152-159):
```ruby
resources :leases, only: [:index, :show] do
  member do
    get :preview
    post :request_signature
    get :download
  end
end
```

## Files to Create

### 1. Controller: `app/controllers/owner/leases_controller.rb`

```ruby
class Owner::LeasesController < ApplicationController
  layout 'owner'
  
  def index
    # List all leases
  end
  
  def show
    # View lease details
  end
  
  def preview
    # Preview generated lease PDF
  end
  
  def request_signature
    # Request signature (POST action)
  end
  
  def download
    # Download signed lease
  end
end
```

### 2. Views to Create

#### a. `app/views/owner/leases/index.html.erb`
**Purpose**: List all leases with filters and status badges
**Design Requirements** (from spec lines 567-576):
- Card or table layout
- Status badges (pending signature, owner signed, tenant signed, both signed)
- Filters by status
- Signing status indicators
- Download buttons

**Key Features**:
- Lease cards with property name
- Status badges: "En attente signature", "Signé propriétaire", "Signé locataire", "Contrat finalisé"
- Action buttons: "Voir détails", "Télécharger" (if signed)
- Filter buttons for status
- Empty state if no leases

**Sample Data**:
- Lease #1: Appartement T3, Paris 15ème - Both signed - Download available
- Lease #2: Maison T5, Lyon 6ème - Owner signed, tenant pending
- Lease #3: Chambre meublée, Marseille - Pending owner signature

---

#### b. `app/views/owner/leases/show.html.erb`
**Purpose**: View lease details with signature status
**Design Requirements** (from spec lines 578-591):
- Card sections layout
- Status timeline showing signature progress
- Property details section
- Tenant details section
- Action buttons based on status

**Key Sections**:
1. **Header**: Lease title with status badge
2. **Signature Status Timeline**: Visual indicator of signing progress
3. **Property Information**: Address, type, rent details
4. **Tenant Information**: Name, contact
5. **Lease Terms**: Duration, start date, deposit
6. **Action Buttons**: 
   - "Prévisualiser le bail" (always available)
   - "Télécharger le bail" (if both signed)
   - "Demander signature" (if owner signed but tenant hasn't)

**Signature Status States**:
- 🔴 Not signed by anyone
- 🟡 Owner signed, tenant pending
- 🟢 Both parties signed

---

#### c. `app/views/owner/leases/preview.html.erb`
**Purpose**: Preview generated lease PDF before requesting signatures
**Design Requirements** (from spec lines 593-602):
- PDF viewer frame/iframe
- Lease type badge (Nue/Meublé/Chambre)
- Request signature button (primary)
- Edit property details link (if not signed yet)

**Key Features**:
- PDF preview area (simulated with placeholder)
- Lease information card:
  - Property address
  - Lease type badge
  - Tenant name
  - Key dates (start date, duration)
- Action buttons:
  - "Demander la signature" (primary button)
  - "Modifier les détails du bien" (link, only if unsigned)
  - "Retour" (secondary button)

**Note**: Since we're creating mockups, the PDF viewer will be a placeholder frame with sample content.

---

#### d. `app/views/owner/leases/download.html.erb`
**Purpose**: Download page for signed leases
**Design Requirements**:
- Success confirmation
- Lease details summary
- Download button
- Next steps information

**Key Features**:
- Success message indicating lease is finalized
- Lease summary card:
  - Property name
  - Tenant name
  - Lease period
  - Signature dates (owner & tenant)
- Large download button
- Information about next steps (payment, move-in, etc.)
- Link back to leases list

---

### 3. Update `app/views/pages/links.html.erb`

Add to Owner Routes section (around line 387):

```erb
<h3 class="font-semibold text-gray-700 mb-2 mt-3">Leases</h3>
<ul class="space-y-1 text-sm">
  <li class="flex items-center">
    <span class="bg-green-100 text-green-800 text-xs font-semibold px-2 py-1 rounded mr-2">GET</span>
    <%= link_to owner_leases_path, class: "text-blue-600 hover:underline" do %>
      /owner/leases
    <% end %>
  </li>
  <li class="flex items-center">
    <span class="bg-green-100 text-green-800 text-xs font-semibold px-2 py-1 rounded mr-2">GET</span>
    <%= link_to owner_lease_path(id: 1), class: "text-blue-600 hover:underline" do %>
      /owner/leases/:id
    <% end %>
  </li>
  <li class="flex items-center">
    <span class="bg-green-100 text-green-800 text-xs font-semibold px-2 py-1 rounded mr-2">GET</span>
    <%= link_to preview_owner_lease_path(id: 1), class: "text-blue-600 hover:underline" do %>
      /owner/leases/:id/preview
    <% end %>
  </li>
  <li class="flex items-center">
    <span class="bg-green-100 text-green-800 text-xs font-semibold px-2 py-1 rounded mr-2">GET</span>
    <%= link_to download_owner_lease_path(id: 1), class: "text-blue-600 hover:underline" do %>
      /owner/leases/:id/download
    <% end %>
  </li>
</ul>
```

Replace the existing placeholder lines 390-403.

---

## Design System Usage

All views must use the OLAK Design System as defined in `app/views/pages/typography2.html.erb`:

### Typography
- H1: `text-5xl font-bold text-olak-primary-dark leading-tight`
- H2: `text-4xl font-bold text-olak-primary-dark leading-snug`
- H3: `text-2xl font-semibold text-olak-dark`
- Body: `text-base text-olak-dark leading-relaxed`

### Colors
- Primary: `#9C8671` (bg-olak-primary)
- Primary Dark: `#7A6656` (bg-olak-primary-dark)
- Success: `#4CAF50` (bg-olak-success)
- Warning: `#FF9800` (bg-olak-warning)
- Error: `#F44336` (bg-olak-error)

### Components
- Cards: `card-olak` class or `bg-white rounded-xl shadow-md p-8`
- Buttons: `btn-primary`, `btn-secondary`
- Badges: `badge badge-success`, `badge badge-pending`, `badge badge-error`
- Alerts: Border-left style with appropriate colors

### Layout
- Use `owner` layout (already included in controller)
- Max width container: `max-w-7xl mx-auto px-4 sm:px-6 lg:px-8`
- Grid for responsive design: `grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6`

---

## Sample Data

### Lease #1 - Fully Signed
- ID: 1
- Property: "Appartement T3 - Paris 15ème"
- Tenant: "Marie Dupont"
- Type: "Meublé"
- Monthly Rent: 1,200€
- Deposit: 2,400€
- Start Date: 01/12/2024
- Duration: 12 months
- Status: Both signed
- Owner Signature Date: 15/11/2024
- Tenant Signature Date: 18/11/2024

### Lease #2 - Partial Signed
- ID: 2
- Property: "Maison T5 - Lyon 6ème"
- Tenant: "Pierre Martin"
- Type: "Nue"
- Monthly Rent: 1,800€
- Deposit: 3,600€
- Start Date: 15/12/2024
- Duration: 36 months
- Status: Owner signed, tenant pending
- Owner Signature Date: 18/11/2024
- Tenant Signature Date: (pending)

### Lease #3 - Unsigned
- ID: 3
- Property: "Chambre meublée - Marseille"
- Tenant: "Sophie Bernard"
- Type: "Chambre meublée"
- Monthly Rent: 450€
- Deposit: 450€
- Start Date: 01/01/2025
- Duration: 9 months
- Status: Pending signatures
- Owner Signature Date: (pending)
- Tenant Signature Date: (pending)

---

## Implementation Order

1. ✅ Create controller with empty actions
2. ✅ Create index view (lease list)
3. ✅ Create show view (lease details)
4. ✅ Create preview view (PDF preview)
5. ✅ Create download view (download page)
6. ✅ Update links.html.erb with routes
7. ✅ Test all pages in browser

---

## Notes

- This is a mockup implementation, so no actual database queries or PDF generation
- All data will be hardcoded in views for demonstration
- Focus on UI/UX and design system compliance
- Signature workflow is simulated (no actual e-signature integration)
- Routes already exist in `config/routes.rb`, no changes needed
- Controller should only have empty action methods (no logic)