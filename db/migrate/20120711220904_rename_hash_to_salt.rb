class RenameHashToSalt < ActiveRecord::Migration
  def up
    rename_column :users, :hash, :salt
  end

  def down
    rename_column :users, :salt, :hash
  end
end
