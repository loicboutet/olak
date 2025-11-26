module Mockups
  class AdminController < ApplicationController
    layout 'mockup_admin'
    
    # Skip authentication for mockups in development
    # skip_before_action :authenticate_user!, if: -> { Rails.env.development? }
    
    # Admin mockup pages (17 pages according to spec)
    def dashboard; end
    def owners_list; end
    def owner_detail; end
    def owner_create; end
    def tenants_list; end
    def tenant_detail; end
    def properties_list; end
    def property_detail; end
    def applications_list; end
    def rating_form; end
    def rating_show; end
    def rating_edit; end
    def visits_calendar; end
    def visit_form; end
    def visit_edit; end

    def payments_dashboard; end
    def payments_list; end
    def payments_show; end
    def payments_export; end
    
    def invoices_list; end
    def invoice_create; end
    def invoice_show; end
    def invoice_download; end

    def accounting_exports; end
    def accounting_export_download; end
  end
end
