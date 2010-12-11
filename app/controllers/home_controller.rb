class HomeController < ApplicationController
  layout 'standard'

  include ApplicationHelper

  def index
    @title = "Spengler - A bumpy journey into the semantic web."
  end
end
