class Activation < ActiveRecord::Base
  include ApplicationHelper
  belongs_to :user

  def new
    code = generate_unique_code

    puts "New activation created with code = " + code
  end

  # #############################################################
  # Called by the rails framework before the activation is saved
  # to the database.
  # #############################################################
  def validate
    self.code = generate_unique_code
  end
end
