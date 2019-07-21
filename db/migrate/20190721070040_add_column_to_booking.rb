class AddColumnToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :ot_20, :integer
    add_column :bookings, :ot_40, :integer
    add_column :bookings, :fr_20, :integer
    add_column :bookings, :fr_40, :integer
  end
end
