class Owner::PaymentsController < ApplicationController
  layout 'owner'
  
  def index
    # List all payments for the owner
    # Mockup: Display payment history with filters
  end
  
  def show
    # Show individual payment details
    # Mockup: Display payment details, transaction info, invoice link
  end
  
  def new
    # Payment form for Stripe
    # Mockup: Display payment form with zone-based pricing
  end
  
  def create
    # Process payment (Stripe integration)
    # Mockup: Redirect to success page
  end
  
  def success
    # Payment success confirmation
    # Mockup: Display success message and next steps
  end
  
  def cancel
    # Payment cancelled/failed
    # Mockup: Display cancellation message with retry option
  end
end
