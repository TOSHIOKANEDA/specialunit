class RenamePortToEqcColumnBookings < ActiveRecord::Migration[5.2]
  def change
    rename_column :bookings, :port, :eqc_column
  end
end
