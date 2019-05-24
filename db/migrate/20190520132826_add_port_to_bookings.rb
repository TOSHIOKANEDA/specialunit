class AddPortToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :port, :string
  end
end
