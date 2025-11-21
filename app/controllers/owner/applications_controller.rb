class Owner::ApplicationsController < ApplicationController
  layout 'owner'
  
  def index
    # List all applications proposed by admin
  end
  
  def show
    # Show application details with candidate profile
  end
  
  def accept
    # Accept candidate application
  end
  
  def reject
    # Reject candidate application
  end
end
