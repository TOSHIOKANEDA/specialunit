class RenameTypeToPickUpBookings < ActiveRecord::Migration[5.2]
  def change
    rename_column :bookings, :type, :pick_up
  end
end
