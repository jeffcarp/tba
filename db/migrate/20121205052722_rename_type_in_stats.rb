class RenameTypeInStats < ActiveRecord::Migration
  def change
    rename_column :stats, :type, :action
  end
end
