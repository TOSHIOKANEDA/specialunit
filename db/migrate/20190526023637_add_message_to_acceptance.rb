class AddMessageToAcceptance < ActiveRecord::Migration[5.2]
  def change
    add_column :acceptances, :message, :text
  end
end
