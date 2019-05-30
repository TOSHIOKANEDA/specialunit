class AddPlaceToAcceptance < ActiveRecord::Migration[5.2]
  def change
    add_column :acceptances, :place, :string
  end
end
