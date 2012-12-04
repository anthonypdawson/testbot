class AddResultTable < ActiveRecord::Migration
  def self.up
    create_table :results do |table|
      table.column :created_on, :datetime, :null=>false, :default=>Time.now
      table.column :failures, :text
      table.column :successes, :text
    end
  end

  def self.down
    drop_table :results
  end
end
