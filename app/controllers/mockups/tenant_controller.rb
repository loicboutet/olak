module Mockups
  class TenantController < ApplicationController
    layout 'mockup_tenant'
    
    # Skip authentication for mockups in development
    # skip_before_action :authenticate_user!, if: -> { Rails.env.development? }
    
    # Tenant mockup pages (13 pages according to spec)
    def dashboard; end
    def profile_show; end
    def profile_edit; end
    def documents; end

    def guarantor_show; end
    def guarantor_form; end # new
    def guarantor_edit; end

    def applications_list; end
    def application_show; end
    def leases_list; end
    def lease_show; end
    def lease_preview; end
    def rental_cv; end
    def notifications; end
  end
end
