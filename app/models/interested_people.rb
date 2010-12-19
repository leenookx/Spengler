class InterestedPeople < ActiveRecord::Base
  FORENAME_MIN_LENGTH = 4
  FORENAME_MAX_LENGTH = 20
  SURNAME_MIN_LENGTH = 4
  SURNAME_MAX_LENGTH = 20
  EMAIL_MIN_LENGTH = 10
  EMAIL_MAX_LENGTH = 50

  FORENAME_RANGE = FORENAME_MIN_LENGTH..FORENAME_MAX_LENGTH
  SURNAME_RANGE = SURNAME_MIN_LENGTH..SURNAME_MAX_LENGTH
  EMAIL_RANGE = EMAIL_MIN_LENGTH..EMAIL_MAX_LENGTH

  FORENAME_SIZE = 20
  SURNAME_SIZE = 20
  EMAIL_SIZE = 30

  validates_length_of :first_name, :within => FORENAME_RANGE
  validates_length_of :last_name, :within => SURNAME_RANGE
  validates_length_of :email, :within => EMAIL_RANGE

  validates_format_of     :first_name,
                          :with => /^[A-Z0-9_]*$/i,
                          :message => "must contain only letters, " +
                                      "numbers, and underscores."

  validates_format_of     :last_name,
                          :with => /^[A-Z0-9_]*$/i,
                          :message => "must contain only letters, " +
                                      "numbers, and underscores."

  validates_format_of     :email,
                          :with => /^[A-Z0-9._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i,
                          :message => "must be a valid email address."
end
