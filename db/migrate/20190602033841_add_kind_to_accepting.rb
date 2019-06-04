class AddKindToAccepting < ActiveRecord::Migration[5.2]
  def change
    add_column :acceptings, :kind, :string
  end
end
