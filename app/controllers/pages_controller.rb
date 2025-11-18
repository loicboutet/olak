class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:home, :typography, :typography2]

  def home
    # Public landing page - OLAK announcement
  end

  def links
  end

  def typography
    # Typography showcase page - publicly accessible (compact version)
  end

  def typography2
    # Typography showcase page - publicly accessible (full version)
  end
end
