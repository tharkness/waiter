class Resturaunt < ActiveRecord::Base

  has_many :hostesses

  #columns wait times for 2, 4, 5+ seaters
  #waitlist true or false

end