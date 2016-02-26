class Restaraunt < ActiveRecord::Base

  has_many :hostesses

  #columns wait times for 2, 4, 5+ seaters, address
  #waitlist true or false

end