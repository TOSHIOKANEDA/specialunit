class AddKindToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :kind, :string
  end
end
