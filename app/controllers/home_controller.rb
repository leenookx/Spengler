class HomeController < ApplicationController
  layout 'standard'

  include ApplicationHelper

  def index
    @title = "Dasher - Agile management. Simplified."
  end
end
