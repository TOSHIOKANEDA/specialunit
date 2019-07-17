class ChangeTypeIntegerToStringBookings < ActiveRecord::Migration[5.2]
  def change
    change_column :bookings, :week, :string
    change_column :bookings, :year, :string
  end
end
