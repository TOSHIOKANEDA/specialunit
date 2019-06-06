class AddYearToAccepting < ActiveRecord::Migration[5.2]
  def change
    add_column :acceptings, :year, :integer
  end
end
