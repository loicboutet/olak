# Project Specifications - Property Rental Platform OLAK

## 1. General Information

**Language:** The entire application is in French (interface, documents, communications)

**Target Market:** French rental market with compliance to French rental law (Loi du 6 juillet 1989)

## 2.1 General Project Description

Property rental platform enabling complete rental process management: registration of owners and tenant candidates, visit management, multidimensional candidate rating, document generation, online payment, and electronic signature. The Client will be the sole user with administrator role and agent functions.

## 2.2 Features to Develop

### COMPLETE OLAK MVP 

#### 👤 Admin (Client)
- I can manually create and validate owner accounts
- I can supervise the platform
- I can manage my visit calendar
- I can rate candidates after visits (multidimensional rating system)
- I can propose candidates to owners
- I can manually validate documents
- I can view payment dashboard and monthly revenue
- I can export accounting data
- I can manually generate invoices if needed

#### 👑 Owner
- I can register (manual validation by admin)
- I can add my properties with complete wizard form
- I can view proposed candidates with their multidimensional rating (salary, guarantors, contract duration, agent feeling)
- I can select my preferred candidate
- I can pay online (credit card) via Stripe according to my zone
- I can electronically sign the lease
- I can download the lease as PDF
- I can view my payment/invoice history
- I can receive email notifications

#### 🏠 Tenant/Candidate
- I can register via link
- I can upload my complete documents (ID card, work contract, 3 pay slips, 3 rent receipts, guarantor information)
- I can view my status (pending/accepted/rejected)
- I can electronically sign the lease
- I can download my rental CV as PDF
- I can share my rental CV via link to other owners

#### ⚙️ System Features
- Multi-profile authentication
- Property management wizard (dynamic adaptive form)
- Document upload and storage (PDF, images)
- Multidimensional rating system (salary/rent, contract type, guarantors, duration, agent feeling)
- Stripe payment integration (secure credit card)
- Zone-based pricing
- Automatic PDF invoice generation (legally compliant)
- Automatic PDF lease generation (3 types: furnished/unfurnished/furnished room)
- Electronic signature via SignNow (desktop + mobile)
- Shareable rental CV (unique link)
- Automatic email notifications
- Responsive web interface
- Dashboard for each profile

#### 🎁 Included Bonus
- Public landing page announcing Olak's arrival (single page)

## 2.3 Property Management - Detailed Specifications

### 2.3.1 Property Types Workflow

The "Add Property" wizard adapts based on the owner's rental objective:

**Initial Question:** "Que souhaitez-vous louer ?" (What do you want to rent?)

#### Scenario A: Appartement entier (Entire Apartment)
```
Appartement → Appartement Form → Immeuble Form
```

#### Scenario B: Maison entière (Entire House)
```
Maison → Maison Form
```

#### Scenario C: Une Chambre (A Room)
```
Chambre → Sub-question: "Où se situe la chambre ?" (Where is the room located?)
  ├─ If Appartement: Appartement Form → Chambre Form → Immeuble Form
  └─ If Maison: Maison Form → Chambre Form
```

### 2.3.2 Form Logic and Conditional Fields

**Field Syntax Convention:**
- **Slash (/)** = Single selection (radio buttons)
  - Example: "Bien : Meublé / Nue"
- **Comma (,)** = Multiple selection (checkboxes)
  - Example: "Equipement : Cuisine équipée, Installation sanitaire"

**Dynamic Display:**
- Fields must show/hide based on previous answers
- Tooltips (info bubbles) must be displayed to guide property owners
- Form validation adapts to property type and rental type

### 2.3.3 Automatic Calculations

#### Security Deposit (Caution)
```
If Type = "Nue" (Unfurnished):
  Caution = Loyer Hors Charges × 1

If Type = "Meublé" (Furnished - applies to apartments, houses, and rooms):
  Caution = Loyer Hors Charges × 2
```

#### Total Monthly Rent
```
Loyer Total Mensuel = Loyer Hors Charges + Montant des Charges
```

### 2.3.4 "Zone Tendue" (High-Demand Area) Validation

**Implementation:**
- Database of French cities classified as "Zone Tendue" must be integrated
- Automatic verification when address is entered
- If property is in "Zone Tendue":
  - Display specific section with rent regulation information
  - Show warning message
  - Provide link to official rent reference information
- If property is NOT in "Zone Tendue":
  - Keep section hidden

### 2.3.5 Repeatable Fields (Equipment)

For equipment fields (heating, appliances, etc.), implement dynamic addition interface:
- User selects equipment type (Chaudière, Climatisation, etc.)
- Specifies quantity
- Enters maintenance date for each unit

**Example:** 
- Add Chaudière → Quantity: 2 → Maintenance dates: Unit 1 (mm/yyyy), Unit 2 (mm/yyyy)

### 2.3.6 Document Upload

**Accepted Formats:** PDF, Images (JPG, PNG)

**Size Limit:** To be determined (recommended: 10MB per file)

**Mandatory vs Optional:**
- Fields marked with asterisk (*) = Mandatory documents
- Fields without asterisk = Optional documents

**Document Types:**
- Règlement intérieur
- DPE (Diagnostic de Performance Énergétique)
- Constat de risque d'exposition au plomb (Crep)
- Diagnostic amiante
- État de l'installation intérieure d'électricité et de gaz
- État des risques naturels et technologiques
- Autorisation préalable de mise en location
- Règlement de copropriété

### 2.3.7 Lease Generation (PDF)

**Three Types of Leases:**
1. **Location nue** (Unfurnished rental)
2. **Location meublée** (Furnished rental)
3. **Location chambre meublée** (Furnished room rental)

**Generation Logic:**
- Dynamic template with conditional sections based on:
  - Property type (Appartement/Maison/Chambre)
  - Rental type (Nue/Meublée)
  - Owner choices (APL recipient, charges, heating, etc.)
  - Zone tendue status
  - Guarantor type (Physical person/Visale)
  
**Annexes:**
- Notice d'information (standard unique PDF, no variants)
- Property diagnostics (DPE, etc.)
- Règlement de copropriété extracts
- Property-specific documents

### 2.3.8 Data Validation

**For MVP - No automatic French regulatory validation:**
- Display all relevant fields for rent reference amounts
- Show informational warnings when applicable
- Let property owner fill in information
- No automatic validation against official rent ceiling databases

## 2.4 User Profiles Detailed

### Owner (Propriétaire)

**Profile Types:**
- Physical person (Personne physique)
- Legal entity (Personne morale): SCI, SARL, SAS

**Information Captured:**
- Personal information (name, birth date, address)
- Alternative mailing address (optional)
- Billing address
- RIB (bank details)
- Identity documents
- Property tax documents
- Company information (if applicable)

**Co-ownership:** Option to add second owner to leases

### Guarantor (Garant)

**Eligibility:**
- Reserved for persons aged 18-30
- Persons 30+ in professional transition, relocation, new position

**Coverage:**
- Unpaid rent up to €1,300 (€1,500 in Île-de-France)
- Security deposit up to 2 months rent
- Property damage coverage
- Up to 36 monthly payments covered

**Information Captured:**
- Personal information
- Professional situation and employment type
- Net monthly salary
- Seniority in current position
- Required documents: ID, employment contract, pay slips, tax notice

### Tenant/Candidate (Locataire)

**Required Documents:**
- Identity card
- Employment contract (with start date affecting number of pay slips required)
- 3 most recent pay slips
- Last tax notice
- Phone number and email

## 2.5 Payment and Pricing

**Stripe Integration:**
- Secure credit card payment
- Zone-based pricing structure
- Payment history accessible to owners
- Automatic invoice generation

**Payment Triggers:**
- Owner pays after candidate selection
- Fee based on property location zone

## 2.6 Electronic Signature

**SignNow Integration:**
- Desktop and mobile compatible
- Documents requiring signature:
  - Lease contract (Bail de location)
  - Both owner and tenant must sign
- Signed documents downloadable as PDF

## 2.7 Explicitly Excluded Elements

The following elements are explicitly excluded from MVP scope:
- Multi-user "Agent" role (Client will be the sole agent via admin account)
- Property geolocation and map display
- Native mobile application (iOS/Android)
- Integration with external platforms (Le Bon Coin, SeLoger, etc.)
- Internal messaging system between users
- Advanced accounting management
- Post-signature rental management module (recurring rent, charges, inventory)
- Automatic ID document verification by AI
- Recurring payment system for rent
- AI-generated listing descriptions
- Automatic validation against official French rent control databases

## 2.8 Future Features (Post-MVP)

To be developed after MVP launch:
- Entry and exit workflows (États des lieux)
- First appointment scheduling
- Additional tenant lifecycle management features

---

This feature list constitutes the contractual scope of developments to be completed for the MVP.
