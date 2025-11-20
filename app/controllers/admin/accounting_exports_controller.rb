class Admin::AccountingExportsController < ApplicationController
  layout 'admin'
  
  # GET /admin/accounting_exports
  # List exports and export form
  def index
    # Mockup: No logic needed, just render
  end
  
  # POST /admin/accounting_exports
  # Generate export (mockup - no actual file generation)
  def create
    # Mockup: No logic needed
    # In real implementation, this would generate and queue export
  end
  
  # GET /admin/accounting_exports/:id/download
  # Download previously generated export
  def download
    # Mockup: No logic needed, just render
    # In real implementation, this would send the generated file
  end
end
