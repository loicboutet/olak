class Owner::PropertiesController < ApplicationController
  layout 'owner'
  
  def index
    # List all properties for the owner
  end
  
  def show
    # Show property details
  end
  
  def new
    # Step 1: Property type selection
  end
  
  def create
    # Create property (step 1)
  end
  
  def edit
    # Edit existing property
  end
  
  def update
    # Update property
  end
  
  def destroy
    # Delete property
  end
  
  def wizard_step_two
    # Step 2: Property details form
  end
  
  def wizard_step_three
    # Step 3: Building/Additional details
  end
  
  def update_step_two
    # Update step 2 data
  end
  
  def update_step_three
    # Update step 3 data
  end
  
  def publish
    # Publish property
  end
  
  def archive
    # Archive property
  end
end
