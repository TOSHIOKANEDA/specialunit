class ChangeTypeVacherToTextBookings < ActiveRecord::Migration[5.2]
  def change
    change_column :bookings, :eqc_column, :text
  end
end
