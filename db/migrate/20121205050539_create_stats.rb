class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.string :type
      t.integer :user_id

      t.timestamps
    end
  end
end
