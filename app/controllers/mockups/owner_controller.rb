module Mockups
  class OwnerController < ApplicationController
    layout 'mockup_owner'
    
    # Skip authentication for mockups in development
    # skip_before_action :authenticate_user!, if: -> { Rails.env.development? }
    
    # Owner mockup pages (22 pages according to spec)
    def dashboard; end
    def profile_show; end
    def profile_edit; end
    def property_step1; end
    def property_step2_apartment; end
    def property_step2_house; end
    def property_step2_room; end
    def property_step3_building; end
    def property_step3_room; end
    def equipment_interface; end
    def properties_list; end
    def property_show; end
    def applications_list; end
    def application_detail; end
    def leases_list; end
    def lease_show; end
    def lease_preview; end
    def payment_form; end
    def payment_success; end
    def payments_list; end
    def invoices_list; end
    def notifications; end
  end
end
