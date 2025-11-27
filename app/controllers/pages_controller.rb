class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:home, :typography, :typography2]

  def home
    # Public landing page - OLAK announcement
    redirect_to mockups_root_path
  end

  def links
  end

  def typography
    # Typography showcase page - publicly accessible (compact version)
  end

  def typography2
    # Typography showcase page - publicly accessible (full version)
  end

  def about
    # Public about page - Company information
  end

  def contact
    # Public contact page - Contact form
  end

  def contact_submit
    # Handle contact form submission (mockup - no email sending)
    # In a real implementation, this would send an email
    redirect_to contact_path, notice: "Merci pour votre message ! Nous vous répondrons dans les plus brefs délais."
  end
end
