class AddTkNumberToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :tk_number, :string
  end
end
