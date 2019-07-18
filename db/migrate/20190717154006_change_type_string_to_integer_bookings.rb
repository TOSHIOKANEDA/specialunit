class ChangeTypeStringToIntegerBookings < ActiveRecord::Migration[5.2]
  def change
    change_column :bookings, :week, :integer
    change_column :bookings, :year, :integer
  end
end
