class AddCanpostToUsers < ActiveRecord::Migration
  def change
    add_column :users, :canpost, :boolean, default: false
    remove_column :users, :salt
  end
end
