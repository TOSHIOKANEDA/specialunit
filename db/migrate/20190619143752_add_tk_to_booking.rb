class AddTkToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :tk, :integer
  end
end
