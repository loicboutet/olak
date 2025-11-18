class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:typography, :typography2]

  def typography
    # Typography showcase page - publicly accessible (compact version)
  end

  def typography2
    # Typography showcase page - publicly accessible (full version)
  end
end
