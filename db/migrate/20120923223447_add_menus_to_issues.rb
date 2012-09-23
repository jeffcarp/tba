class AddMenusToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :foss, :string
    add_column :issues, :dana, :string
    add_column :issues, :bobs, :string
  end
end
