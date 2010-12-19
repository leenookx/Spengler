class Activation < ActiveRecord::Base
  belongs_to :user

  # #############################################################
  # Called by the rails framework before the activation is saved
  # to the database.
  # #############################################################
  def validate
    code = generate_unique_code
  end
end
