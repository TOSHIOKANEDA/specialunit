class AddPlaceToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :place, :string
  end
end
