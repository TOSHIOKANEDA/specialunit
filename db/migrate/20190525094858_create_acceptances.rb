class CreateAcceptances < ActiveRecord::Migration[5.2]
  def change
    create_table :acceptances do |t|
      t.string :status

      t.timestamps
    end
  end
end
