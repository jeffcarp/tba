class SwitchMenusFromStringToText < ActiveRecord::Migration
  def change
    change_column :issues, :foss, :text
    change_column :issues, :dana, :text
    change_column :issues, :bobs, :text
  end
end
