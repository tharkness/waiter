class Hostess < ActiveRecord::Base

  belongs_to :restaurant

  #needs method to update resturaunt wait times
  #resturaunt_id, username, password

  def increase_two_seat_wait
    restaurant.increment(:two_seat_wait, 2)
    restaurant.save
    return restaurant.two_seat_wait
  end

  def increase_four_seat_wait
    restaurant.increment(:four_seat_wait, 2)
    restaurant.save
    return restaurant.four_seat_wait
  end

  def increase_large_table_wait
    restaurant.increment(:large_table_wait, 2)
    restaurant.save
    return restaurant.large_table_wait
  end

  def decrease_two_seat_wait
    restaurant.decrement(:two_seat_wait, 2)
    restaurant.save
    return restaurant.two_seat_wait
  end

  def decrease_four_seat_wait
    restaurant.decrement(:four_seat_wait, 2)
    restaurant.save
    return restaurant.four_seat_wait
  end

  def decrease_large_table_wait
    restaurant.decrement(:large_table_wait, 2)
    restaurant.save
    return restaurant.large_table_wait
  end

  def reset_two_seat_wait
    restaurant.two_seat_wait = 0
    restaurant.save
    return restaurant.two_seat_wait
  end

  def reset_four_seat_wait
    restaurant.four_seat_wait = 0
    restaurant.save
    return restaurant.four_seat_wait
  end

  def reset_large_table_wait
    restaurant.large_table_wait = 0
    restaurant.save
    return restaurant.large_table_wait
  end

  def save_changes
    restaurant.save
  end

end