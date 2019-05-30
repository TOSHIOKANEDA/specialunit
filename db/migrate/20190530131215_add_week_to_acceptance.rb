class AddWeekToAcceptance < ActiveRecord::Migration[5.2]
  def change
    add_column :acceptances, :week, :integer
  end
end
