class UserLinks < ActiveRecord::Base
  belongs_to :user
  belongs_to :links
end