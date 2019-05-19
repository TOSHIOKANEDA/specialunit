class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.integer       :volume
      t.string        :status
      t.text          :main_column
      t.text          :sub_column
      t.integer       :week
      t.timestamps    null: true
    end
  end
end
