class AddReceiveToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :receive, :boolean, :default => true
  end
end
