class AddDinnerMenus < ActiveRecord::Migration
  def change
    add_column :issues, :foss_dinner, :text
    add_column :issues, :dana_dinner, :text
    add_column :issues, :bobs_dinner, :text
  end
end
