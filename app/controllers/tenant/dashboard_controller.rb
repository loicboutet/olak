class Tenant::DashboardController < ApplicationController
  layout 'tenant'
  
  def index
    # Tenant dashboard - application status, document validation status, pending actions
    # Future: Add actual data from models
  end
end
