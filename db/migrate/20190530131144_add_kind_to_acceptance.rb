class AddKindToAcceptance < ActiveRecord::Migration[5.2]
  def change
    add_column :acceptances, :kind, :string
  end
end
