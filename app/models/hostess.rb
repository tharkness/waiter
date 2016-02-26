class Hostess < ActiveRecord::Base

  belongs_to :restaraunt

  #needs method to update resturaunt wait times
  #resturaunt_id, username, password

  def increase_two_seat_wait
    restaraunt.increment(:two_seat_wait, 2)
    restaraunt.save
  end

  def increase_four_seat_wait
    restaraunt.increment(:four_seat_wait, 2)
    restaraunt.save
  end

  def increase_large_table_wait
    restaraunt.increment(:large_table_wait, 2)
    restaraunt.save
  end

  def decrease_two_seat_wait
    restaraunt.decrement(:two_seat_wait, 2)
    restaraunt.save
  end

  def decrease_four_seat_wait
    restaraunt.decrement(:four_seat_wait, 2)
    restaraunt.save
  end

  def decrease_large_table_wait
    restaraunt.decrement(:large_table_wait, 2)
    restaraunt.save
  end

  def reset_two_seat_wait
    restaraunt.two_seat_wait = 0
    restaraunt.save
  end

  def reset_four_seat_wait
    restaraunt.four_seat_wait = 0
    restaraunt.save
  end

  def reset_large_table_wait
    restaraunt.large_table_wait = 0
    restaraunt.save
  end

  def save_changes
    restaraunt.save
  end

end