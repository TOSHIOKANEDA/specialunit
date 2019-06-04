class AddWeekToAccepting < ActiveRecord::Migration[5.2]
  def change
    add_column :acceptings, :week, :integer
  end
end
