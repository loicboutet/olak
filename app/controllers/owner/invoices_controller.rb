class Owner::InvoicesController < ApplicationController
  layout 'owner'
  
  def index
    # List all invoices for the owner
    # Mockup: Display invoice history with filters and download options
  end
  
  def show
    # Show individual invoice details
    # Mockup: Display invoice details with download button
  end
  
  def download
    # Download invoice as PDF
    # Mockup: Would typically serve PDF file
  end
end
