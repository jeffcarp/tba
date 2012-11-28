class AddAnonToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :anon, :boolean, :default => false
  end
end
