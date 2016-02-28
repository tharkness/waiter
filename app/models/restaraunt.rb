class Restaraunt < ActiveRecord::Base

  has_many :hostesses

  validates :name, uniqueness: true
  validates :address, uniqueness: true

  #columns wait times for 2, 4, 5+ seaters, address
  #waitlist true or false

  def self.search(term)
    where("name like ?", "%#{term}%")
  end

end