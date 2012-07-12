class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.date :publish_date

      t.timestamps
    end
  end
end
