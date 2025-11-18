# Data Model - OLAK Platform

## Overview

This document describes the complete data model for the OLAK property rental platform. The application uses SQLite with ActiveRecord (Rails 8).

## Core Entities

### 1. Users

Base authentication table for all user types.

```ruby
users
  - id (primary key)
  - email (string, unique, indexed)
  - encrypted_password (string)
  - role (enum: admin, owner, tenant)
  - confirmed_at (datetime) # Email confirmation
  - confirmation_token (string)
  - reset_password_token (string)
  - reset_password_sent_at (datetime)
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `has_one :admin_profile` (if role = admin)
- `has_one :owner_profile` (if role = owner)
- `has_one :tenant_profile` (if role = tenant)

---

### 2. Admin Profiles

```ruby
admin_profiles
  - id (primary key)
  - user_id (foreign key, indexed, unique)
  - first_name (string)
  - last_name (string)
  - phone_number (string)
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `belongs_to :user`

---

### 3. Owner Profiles

```ruby
owner_profiles
  - id (primary key)
  - user_id (foreign key, indexed, unique)
  - status (enum: pending, validated, rejected) # Manual validation by admin
  - owner_type (enum: physical_person, legal_entity)
  
  # Personal Information (Physical Person)
  - gender (enum: monsieur, madame)
  - first_name (string)
  - last_name (string)
  - birth_date (date)
  - birth_place (string)
  - address (text)
  - alternative_mailing_address (text)
  - billing_address (text)
  - phone_number (string)
  
  # Legal Entity Information
  - company_type (enum: sci, sarl, sas)
  - company_name (string)
  - company_address (text)
  - company_email (string)
  - siren_number (string)
  - rcs_address (string)
  - company_billing_address (text)
  - sci_composition (enum: family_only, non_family) # For SCI only
  
  # Co-ownership
  - has_co_owner (boolean, default: false)
  
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `belongs_to :user`
- `has_one :co_owner_profile` (optional)
- `has_many :properties`
- `has_many :payments`
- `has_many :invoices`

**Attached Documents:**
- `identity_card` (Active Storage)
- `rib` (Active Storage)
- `property_tax_document` (Active Storage)

---

### 4. Co-Owner Profiles

```ruby
co_owner_profiles
  - id (primary key)
  - owner_profile_id (foreign key, indexed, unique)
  - gender (enum: monsieur, madame)
  - first_name (string)
  - last_name (string)
  - birth_date (date)
  - birth_place (string)
  - address (text)
  - alternative_mailing_address (text)
  - phone_number (string)
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `belongs_to :owner_profile`

---

### 5. Tenant Profiles

```ruby
tenant_profiles
  - id (primary key)
  - user_id (foreign key, indexed, unique)
  - status (enum: pending, accepted, rejected)
  - gender (enum: monsieur, madame)
  - first_name (string)
  - last_name (string)
  - birth_date (date)
  - birth_place (string)
  - phone_number (string)
  
  # Employment Information
  - employment_status (enum: cdd, cdi, independent, seasonal, civil_servant, unemployed, other)
  - employment_activity (string)
  - monthly_net_salary (decimal, precision: 10, scale: 2)
  - employment_seniority (enum: less_3_months, more_3_months, more_1_year, more_2_years, more_4_years, more_6_years, more_10_years)
  
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `belongs_to :user`
- `has_one :guarantor`
- `has_many :applications` (rental applications)
- `has_many :ratings` (from admin)

**Attached Documents:**
- `identity_card` (Active Storage)
- `employment_contract` (Active Storage)
- `pay_slip_1` (Active Storage)
- `pay_slip_2` (Active Storage)
- `pay_slip_3` (Active Storage)
- `tax_notice` (Active Storage)

---

### 6. Guarantors

```ruby
guarantors
  - id (primary key)
  - tenant_profile_id (foreign key, indexed)
  - guarantor_type (enum: physical_person, visale)
  
  # Physical Person Guarantor
  - gender (enum: monsieur, madame)
  - first_name (string)
  - last_name (string)
  - birth_date (date)
  - birth_place (string)
  - address (text)
  - phone_number (string)
  - email (string)
  
  # Employment Information
  - employment_status (enum: cdd, cdi, independent, seasonal, civil_servant, unemployed, other)
  - employment_activity (string)
  - monthly_net_salary (decimal, precision: 10, scale: 2)
  - employment_seniority (enum: less_3_months, more_3_months, more_1_year, more_2_years, more_4_years, more_6_years, more_10_years)
  
  # Visale Guarantor
  - visale_number (string)
  - visale_issued_date (date)
  
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `belongs_to :tenant_profile`

**Attached Documents (if physical_person):**
- `identity_card` (Active Storage)
- `employment_contract` (Active Storage)
- `pay_slip_1` (Active Storage)
- `pay_slip_2` (Active Storage)
- `pay_slip_3` (Active Storage)
- `tax_notice` (Active Storage)

---

## Property Management

### 7. Properties

Main property table (polymorphic based on property_type).

```ruby
properties
  - id (primary key)
  - owner_profile_id (foreign key, indexed)
  - property_type (enum: apartment, house, room)
  - rental_type (enum: furnished, unfurnished)
  - status (enum: draft, active, rented, archived)
  
  # Address
  - street_number (string)
  - street_name (string)
  - postal_code (string)
  - city (string)
  - floor (string) # For apartments
  - door_number (string)
  - door_position (string) # left/right
  
  # Zone Tendue
  - is_zone_tendue (boolean, default: false)
  - zone_tendue_link (string)
  
  # Basic Information
  - dwelling_purpose (enum: residential, mixed_professional)
  - surface_area (decimal, precision: 10, scale: 2)
  - main_rooms_count (integer)
  - bedrooms_count (integer)
  - bathrooms_count (integer)
  - toilets_count (integer)
  
  # Energy Performance
  - energy_class (enum: a, b, c, d, e, f, g)
  - dpe_date (date)
  
  # Noise Zone
  - noise_zone (enum: none, zone_a, zone_b, zone_c, zone_d)
  
  # Tax
  - fiscal_identifier (string)
  
  # Rent Information
  - base_rent (decimal, precision: 10, scale: 2)
  - charges_amount (decimal, precision: 10, scale: 2)
  - total_monthly_rent (decimal, precision: 10, scale: 2) # Calculated
  - security_deposit (decimal, precision: 10, scale: 2) # Calculated
  
  # Rent Regulations (Zone Tendue)
  - rent_subject_to_decree (boolean, default: false)
  - rent_subject_to_reference (boolean, default: false)
  - reference_rent_per_sqm (decimal, precision: 10, scale: 2)
  - increased_reference_rent_per_sqm (decimal, precision: 10, scale: 2)
  - has_rent_supplement (boolean, default: false)
  - rent_supplement_amount (decimal, precision: 10, scale: 2)
  - rent_supplement_justification (text)
  
  # APL
  - accepts_apl (boolean, default: true)
  - apl_recipient (enum: owner, tenant)
  
  # Payment Terms
  - payment_frequency (enum: monthly, quarterly, semi_annual, annual)
  - payment_timing (enum: beginning_of_period, end_of_period)
  - payment_day (integer) # Day of month
  
  # Charges
  - charges_recovery_method (enum: provisions_with_regularization, periodic_payment, flat_rate)
  - charges_distribution (text)
  
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `belongs_to :owner_profile`
- `has_one :apartment_detail` (if property_type = apartment)
- `has_one :house_detail` (if property_type = house)
- `has_one :room_detail` (if property_type = room)
- `has_one :building_detail` (for apartments and some rooms)
- `has_many :property_equipments`
- `has_many :property_amenities`
- `has_many :heating_systems`
- `has_many :property_improvements`
- `has_many :applications`
- `has_one :lease`

**Attached Documents:**
- `dpe_document` (Active Storage)
- `lead_exposure_report` (Active Storage, mandatory if before 1949)
- `asbestos_report` (Active Storage, mandatory)
- `electrical_gas_installation_report` (Active Storage, mandatory)
- `natural_technological_risks_report` (Active Storage)
- `internal_regulations` (Active Storage)
- `rental_authorization` (Active Storage)
- `coproperty_regulations` (Active Storage)

---

### 8. Apartment Details

```ruby
apartment_details
  - id (primary key)
  - property_id (foreign key, indexed, unique)
  
  # No additional fields specific to apartment beyond Property base fields
  # All apartment-specific info is in Property and Building
  
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `belongs_to :property`

---

### 9. House Details

```ruby
house_details
  - id (primary key)
  - property_id (foreign key, indexed, unique)
  
  - levels_count (integer)
  - land_surface_area (decimal, precision: 10, scale: 2)
  - has_entry_code (boolean, default: false)
  - entry_code (string)
  - construction_year (integer)
  
  # Technology Access
  - has_tv_reception (boolean, default: false)
  - has_internet (boolean, default: false)
  - has_fiber (boolean, default: false)
  
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `belongs_to :property`

---

### 10. Room Details

```ruby
room_details
  - id (primary key)
  - property_id (foreign key, indexed, unique)
  - container_type (enum: apartment, house) # Where the room is located
  - container_property_id (foreign key) # Links to parent property (apartment/house)
  
  - room_number (string)
  - room_description (string)
  - private_surface_area (decimal, precision: 10, scale: 2)
  - has_private_bathroom (boolean, default: false)
  
  # If has_private_bathroom
  - private_bathroom_has_sink (boolean, default: false)
  - private_bathroom_has_shower (boolean, default: false)
  - private_bathroom_has_bath (boolean, default: false)
  - private_bathroom_has_toilet (boolean, default: false)
  - toilet_in_bathroom (boolean, default: false)
  
  # Rent calculation for zone tendue
  - remaining_rent_to_distribute (decimal, precision: 10, scale: 2)
  
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `belongs_to :property`
- `belongs_to :container_property, class_name: 'Property'` (optional)

---

### 11. Building Details

```ruby
building_details
  - id (primary key)
  - property_id (foreign key, indexed)
  
  - building_type (enum: collective, individual)
  - legal_regime (enum: mono_property, coproperty)
  - construction_year (integer)
  - floors_count (integer)
  - has_entry_code (boolean, default: false)
  - entry_code (string)
  
  # Technology Access
  - has_tv_reception (boolean, default: false)
  - has_internet (boolean, default: false)
  - has_fiber (boolean, default: false)
  
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `belongs_to :property`

---

### 12. Property Equipments

Kitchen, bathrooms, installations (repeatable).

```ruby
property_equipments
  - id (primary key)
  - property_id (foreign key, indexed)
  - equipment_category (enum: kitchen, bathroom, installation)
  - equipment_type (string) # "Cuisine équipée", "Meubles vasques", etc.
  - quantity (integer, default: 1)
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `belongs_to :property`

---

### 13. Property Amenities

Additional parts (grenier, balcon, terrasse, etc.).

```ruby
property_amenities
  - id (primary key)
  - property_id (foreign key, indexed)
  - amenity_type (enum: attic, fitted_attic, balcony, terrace, loggia, garden, pool, other)
  - amenity_description (string) # For "other"
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `belongs_to :property`

---

### 14. Property Private Accessories

Cave, parking, garage (private use).

```ruby
property_private_accessories
  - id (primary key)
  - property_id (foreign key, indexed)
  - accessory_type (enum: cellar, parking, garage, other)
  - accessory_number (string) # e.g., "Cave n°12"
  - accessory_description (string)
  - parking_spaces_count (integer) # For house parking/garage
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `belongs_to :property`

---

### 15. Building Common Accessories

For building (common use).

```ruby
building_common_accessories
  - id (primary key)
  - building_detail_id (foreign key, indexed)
  - accessory_type (enum: bike_storage, elevator, green_spaces, playground, laundry, trash_room, caretaking, other, none)
  - accessory_description (string) # For "other"
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `belongs_to :building_detail`

---

### 16. Heating Systems

Repeatable heating equipment.

```ruby
heating_systems
  - id (primary key)
  - property_id (foreign key, indexed)
  - heating_production (enum: individual, collective)
  - heating_type (enum: electric, fuel_oil, gas, solar, wood, other)
  - heating_description (string) # For "other"
  
  # For fuel_oil and gas
  - fuel_supply (enum: street, bottle)
  
  # For collective heating
  - collective_distribution_method (text) # Proportional to surface, coproperty rules, meter reading
  
  # Water heating
  - water_heating_production (enum: individual, collective)
  - water_heating_type (enum: electric, fuel_oil, gas, solar, wood, other)
  - water_collective_distribution_method (text)
  
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `belongs_to :property`
- `has_many :heating_equipments`

---

### 17. Heating Equipments

Individual equipment items with maintenance dates.

```ruby
heating_equipments
  - id (primary key)
  - heating_system_id (foreign key, indexed)
  - equipment_type (enum: boiler, air_conditioning, heat_pump, wood_heating)
  - quantity (integer, default: 1)
  - last_maintenance_date (date)
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `belongs_to :heating_system`

---

### 18. Property Improvements

Energy and improvement works.

```ruby
property_improvements
  - id (primary key)
  - property_id (foreign key, indexed)
  - improvement_type (enum: energy_work, improvement_work, ongoing_work, tenant_work)
  
  # Energy Work (< 15 years)
  - energy_work_completed (boolean, default: false)
  - energy_work_completion_date (date)
  - energy_work_amount (decimal, precision: 10, scale: 2)
  - energy_work_description (text)
  - energy_contribution_amount (decimal, precision: 10, scale: 2) # Calculated based on rooms
  - energy_contribution_end_date (date) # completion_date + 15 years
  
  # Improvement/Compliance Work (< 6 months)
  - improvement_completed (boolean, default: false)
  - improvement_amount (decimal, precision: 10, scale: 2)
  - improvement_description (text)
  
  # Ongoing Work
  - ongoing_work (boolean, default: false)
  - ongoing_work_description (text)
  - ongoing_work_execution_method (text)
  - ongoing_work_completion_date (date)
  - ongoing_work_rent_increase (decimal, precision: 10, scale: 2)
  
  # Tenant Work (during lease)
  - tenant_work_completed (boolean, default: false)
  - tenant_work_end_date (date)
  - tenant_work_compensation_method (text)
  - tenant_work_description (text)
  
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `belongs_to :property`

**Attached Documents:**
- `energy_work_justification` (Active Storage)
- `tenant_work_justification` (Active Storage)

---

## Rental Process

### 19. Applications

Tenant applications for properties.

```ruby
applications
  - id (primary key)
  - property_id (foreign key, indexed)
  - tenant_profile_id (foreign key, indexed)
  - status (enum: pending, proposed_to_owner, accepted_by_owner, rejected, withdrawn)
  - applied_at (datetime)
  - proposed_at (datetime)
  - owner_decision_at (datetime)
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `belongs_to :property`
- `belongs_to :tenant_profile`
- `has_one :rating` (from admin)

---

### 20. Ratings

Admin ratings for tenant candidates.

```ruby
ratings
  - id (primary key)
  - application_id (foreign key, indexed, unique)
  - admin_profile_id (foreign key, indexed)
  
  # Multidimensional Rating
  - salary_rent_ratio_score (integer) # 1-5
  - contract_type_score (integer) # 1-5
  - guarantors_score (integer) # 1-5
  - contract_duration_score (integer) # 1-5
  - agent_feeling_score (integer) # 1-5
  - overall_score (decimal, precision: 5, scale: 2) # Average
  
  - notes (text)
  - rated_at (datetime)
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `belongs_to :application`
- `belongs_to :admin_profile`

---

### 21. Leases

```ruby
leases
  - id (primary key)
  - property_id (foreign key, indexed, unique)
  - tenant_profile_id (foreign key, indexed)
  - lease_type (enum: unfurnished, furnished, furnished_room)
  - status (enum: draft, pending_signature, signed, active, terminated)
  
  # Dates
  - start_date (date)
  - duration_months (integer) # 12 for furnished, 36 for unfurnished (physical), 72 for unfurnished (legal entity)
  - custom_duration_months (integer) # For special cases
  - custom_duration_justification (text)
  
  # Financial
  - monthly_rent (decimal, precision: 10, scale: 2)
  - charges (decimal, precision: 10, scale: 2)
  - security_deposit (decimal, precision: 10, scale: 2)
  
  # Signature
  - owner_signed_at (datetime)
  - tenant_signed_at (datetime)
  - signnow_document_id (string)
  
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `belongs_to :property`
- `belongs_to :tenant_profile`

**Attached Documents:**
- `signed_lease_pdf` (Active Storage)
- `notice_information_pdf` (Active Storage)

---

## Payment & Invoicing

### 22. Payments

```ruby
payments
  - id (primary key)
  - owner_profile_id (foreign key, indexed)
  - lease_id (foreign key, indexed)
  - amount (decimal, precision: 10, scale: 2)
  - stripe_payment_intent_id (string, indexed)
  - status (enum: pending, succeeded, failed, refunded)
  - zone (string) # For zone-based pricing
  - paid_at (datetime)
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `belongs_to :owner_profile`
- `belongs_to :lease`
- `has_one :invoice`

---

### 23. Invoices

```ruby
invoices
  - id (primary key)
  - payment_id (foreign key, indexed, unique)
  - owner_profile_id (foreign key, indexed)
  - invoice_number (string, unique, indexed)
  - amount (decimal, precision: 10, scale: 2)
  - issued_at (date)
  - created_at (datetime)
  - updated_at (datetime)
```

**Relationships:**
- `belongs_to :payment`
- `belongs_to :owner_profile`

**Attached Documents:**
- `invoice_pdf` (Active Storage)

---

## Supporting Tables

### 24. Zone Tendue Cities

Reference table for French cities in high-demand areas.

```ruby
zone_tendue_cities
  - id (primary key)
  - city_name (string, indexed)
  - postal_code (string, indexed)
  - department (string)
  - zone_type (string) # Type of zone classification
  - reference_link (string) # Link to official rent reference
  - created_at (datetime)
  - updated_at (datetime)
```

---

## Enums Reference

### User Roles
- `admin`: Platform administrator (Client)
- `owner`: Property owner
- `tenant`: Tenant/candidate

### Owner Status
- `pending`: Awaiting admin validation
- `validated`: Approved by admin
- `rejected`: Rejected by admin

### Tenant Status
- `pending`: Application submitted
- `accepted`: Accepted by owner
- `rejected`: Rejected

### Property Types
- `apartment`: Appartement
- `house`: Maison
- `room`: Chambre

### Rental Types
- `furnished`: Meublé
- `unfurnished`: Nue

### Property Status
- `draft`: Being created
- `active`: Available for rent
- `rented`: Currently rented
- `archived`: No longer active

### Lease Types
- `unfurnished`: Location nue
- `furnished`: Location meublée
- `furnished_room`: Location chambre meublée

### Payment Status
- `pending`: Payment initiated
- `succeeded`: Payment successful
- `failed`: Payment failed
- `refunded`: Payment refunded

---

## Indexes Strategy

### High-Priority Indexes
- `users.email` (unique)
- `properties.owner_profile_id`
- `properties.status`
- `applications.property_id`
- `applications.tenant_profile_id`
- `applications.status`
- `payments.stripe_payment_intent_id`
- `invoices.invoice_number` (unique)
- `zone_tendue_cities.city_name`
- `zone_tendue_cities.postal_code`

### Composite Indexes
- `[applications.property_id, applications.status]`
- `[properties.owner_profile_id, properties.status]`
- `[zone_tendue_cities.city_name, zone_tendue_cities.postal_code]`

---

## Active Storage

### Attachments Summary

**Owner Profiles:**
- identity_card, rib, property_tax_document

**Tenant Profiles:**
- identity_card, employment_contract, pay_slip_1, pay_slip_2, pay_slip_3, tax_notice

**Guarantors:**
- identity_card, employment_contract, pay_slip_1, pay_slip_2, pay_slip_3, tax_notice

**Properties:**
- dpe_document, lead_exposure_report, asbestos_report, electrical_gas_installation_report, natural_technological_risks_report, internal_regulations, rental_authorization, coproperty_regulations

**Property Improvements:**
- energy_work_justification, tenant_work_justification

**Leases:**
- signed_lease_pdf, notice_information_pdf

**Invoices:**
- invoice_pdf

---

## Data Validation Rules

### Required Fields by Entity

**Properties (all types):**
- owner_profile_id, property_type, rental_type, address fields, surface_area, energy_class, base_rent

**Apartments:**
- floor, building_detail (required)

**Houses:**
- land_surface_area, construction_year

**Rooms:**
- container_type, private_surface_area

**Owner Profiles (physical_person):**
- first_name, last_name, birth_date, address, phone_number

**Owner Profiles (legal_entity):**
- company_type, company_name, company_address, siren_number

**Tenant Profiles:**
- first_name, last_name, birth_date, employment_status, monthly_net_salary

### Calculated Fields

- `properties.total_monthly_rent = base_rent + charges_amount`
- `properties.security_deposit = base_rent * (rental_type == 'furnished' ? 2 : 1)`
- `property_improvements.energy_contribution_end_date = energy_work_completion_date + 15.years`
- `ratings.overall_score = average of all score fields`

---

## Notes

1. **Polymorphic Associations**: The `Property` model acts as a polymorphic base with specific details in `apartment_details`, `house_details`, or `room_details`.

2. **Document Storage**: Using Active Storage for all file uploads with validation on file type and size.

3. **Soft Deletes**: Consider adding `deleted_at` timestamps for entities that should be archived rather than hard-deleted (properties, users, etc.).

4. **Audit Trail**: Consider adding `paper_trail` gem for tracking changes to critical entities (leases, payments, ratings).

5. **Zone Tendue DB**: Should be seeded from official French government data and updated periodically.

6. **Calculations**: All monetary calculations should use `decimal` type to avoid floating-point errors.

7. **Localization**: All enum values should have French translations in locale files.
