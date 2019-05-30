class CreateAcceptings < ActiveRecord::Migration[5.2]
  def change
    create_table :acceptings do |t|

      t.timestamps
    end
  end
end
