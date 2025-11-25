class MockupsController < ApplicationController
  layout 'mockup_application'
  
  # Skip authentication for mockups in development
  # skip_before_action :authenticate_user!, if: -> { Rails.env.development? }
  
  def index
    # Mockup Journey Explorer - Main index page
    @admin_routes = admin_mockup_routes
    @owner_routes = owner_mockup_routes
    @tenant_routes = tenant_mockup_routes
    @public_route = public_mockup_route
  end
  
  # Public pages
  def public_landing; end
  def about; end
  def contact; end
  def candidats_inscription; end
  def cv_locatif; end
  
  private
  
  # Return array of admin route hashes for index page
  def admin_mockup_routes
    [
      { name: 'Dashboard', path: mockups_admin_dashboard_path },
      { name: 'Gestion Propriétaires', path: mockups_admin_owners_list_path },
      { name: 'Gestion Locataires', path: mockups_admin_tenants_list_path },
      { name: 'Gestion Propriétés', path: mockups_admin_properties_list_path },
      { name: 'Applications', path: mockups_admin_applications_list_path },
      { name: 'Calendrier Visites', path: mockups_admin_visits_calendar_path },
      { name: 'Paiements', path: mockups_admin_payments_dashboard_path },
      { name: 'Factures', path: mockups_admin_invoices_list_path }
    ]
  end
  
  # Return array of owner route hashes for index page
  def owner_mockup_routes
    [
      { name: 'Dashboard', path: mockups_owner_dashboard_path },
      { name: 'Mon Profil', path: mockups_owner_profile_show_path },
      { name: 'Ajouter un Bien', path: mockups_owner_property_step1_path },
      { name: 'Mes Propriétés', path: mockups_owner_properties_list_path },
      { name: 'Candidatures', path: mockups_owner_applications_list_path },
      { name: 'Baux', path: mockups_owner_leases_list_path },
      { name: 'Paiements', path: mockups_owner_payments_list_path },
      { name: 'Factures', path: mockups_owner_invoices_list_path }
    ]
  end
  
  # Return array of tenant route hashes for index page
  def tenant_mockup_routes
    [
      { name: 'Dashboard', path: mockups_tenant_dashboard_path },
      { name: 'Mon Profil', path: mockups_tenant_profile_show_path },
      { name: 'Mes Documents', path: mockups_tenant_documents_path },
      { name: 'Mon Garant', path: mockups_tenant_guarantor_form_path },
      { name: 'Mes Candidatures', path: mockups_tenant_applications_list_path },
      { name: 'Mes Baux', path: mockups_tenant_leases_list_path },
      { name: 'Mon CV Locatif', path: mockups_tenant_rental_cv_path }
    ]
  end
  
  # Return single public route hash
  def public_mockup_route
    { name: "Page d'accueil OLAK", path: mockups_landing_path }
  end
end
