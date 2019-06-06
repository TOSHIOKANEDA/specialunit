class AddYearToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :year, :integer
  end
end
