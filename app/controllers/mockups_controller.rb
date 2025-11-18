class MockupsController < ApplicationController
  # Set the layout based on the action
  layout :resolve_layout
  
  def index
    # Main index page that will list all mockup journeys
  end
  
  # Admin journey pages
  def admin_dashboard
    # Admin dashboard mockup
  end
  
  def admin_users
    # Admin users management mockup
  end
  
  def admin_analytics
    # Admin analytics mockup
  end
  
  # Owner journey pages
  def owner_dashboard
    # Owner dashboard mockup
  end
  
  # Tenant journey pages
  def tenant_dashboard
    # Tenant dashboard mockup
  end
  
  # Legacy user journey pages (for backward compatibility)
  def user_dashboard
    # User dashboard mockup
  end
  
  def user_profile
    # User profile mockup
  end
  
  def user_settings
    # User settings mockup
  end
  
  private
  
  # Determine which layout to use based on the action name
  def resolve_layout
    case action_name
    when 'index'
      'application'
    when /^admin_/
      'admin'
    when /^owner_/
      'owner'
    when /^tenant_/
      'tenant'
    when /^user_/
      'mockup_user' # Legacy support
    else
      'application'
    end
  end
end
