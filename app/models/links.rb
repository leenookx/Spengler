class Links < ActiveRecord::Base
  has_many :user_links

  URL_MIN_LENGTH = 10
  DESCRIPTION_MIN_LENGTH = 0
  KEYWORDS_MIN_LENGTH = 0

  URL_MAX_LENGTH = 4096
  DESCRIPTION_MAX_LENGTH = 4096
  KEYWORDS_MAX_LENGTH = 200

  URL_RANGE = URL_MIN_LENGTH..URL_MAX_LENGTH
  DESCRIPTION_RANGE = DESCRIPTION_MIN_LENGTH..DESCRIPTION_MAX_LENGTH
  KEYWORDS_RANGE = KEYWORDS_MIN_LENGTH..KEYWORDS_MAX_LENGTH

  URL_SIZE = 30
  DESCRIPTION_SIZE = 40
  KEYWORDS_SIZE = 40

  STATUS_SUBMITTED = 0
  STATUS_VERIFIED = 1
  STATUS_BEING_PROCESSED = 2
  STATUS_PROCESSED = 3

  validates_uniqueness_of :url

  validates_length_of :url, :within => URL_RANGE
  validates_length_of :description, :within => DESCRIPTION_RANGE
  validates_length_of :keywords, :within => KEYWORDS_RANGE

  validates_format_of :url,
                      :with => /^http*$/i,
                      :message => "URL must start with either http:// or https://"
end
