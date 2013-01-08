class AddIssueToStats < ActiveRecord::Migration
  def change
  	add_column :stats, :issue_id, :integer
  end
end
