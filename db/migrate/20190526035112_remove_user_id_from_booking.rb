class RemoveUserIdFromBooking < ActiveRecord::Migration[5.2]
  def change
    remove_column :bookings, :booking, :integer
  end
end
