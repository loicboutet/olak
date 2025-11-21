class Tenant::GuarantorsController < ApplicationController
  layout 'tenant'
  
  def show
    # View guarantor details
    # Singulr resource - tenant has one guarantor (Visale OR Physical person)
    # Future: Add actual guarantor data from models
  end
  
  def new
    # Add guarantor form - choose type (Physical person or Visale)
    # Future: Add actual form with type selection
  end
  
  def create
    # Create guarantor
    # Future: Implement guarantor creation logic
  end
  
  def edit
    # Edit guarantor information
    # Future: Add actual guarantor data from models
  end
  
  def update
    # Update guarantor
    # Future: Implement guarantor update logic
  end
  
  def destroy
    # Remove guarantor
    # Future: Implement guarantor deletion logic
  end
end
