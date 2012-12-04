class AddTestCaseTable < ActiveRecord::Migration
  def self.up
    create_table :test_cases do |table|
      table.column :name, :string, :limit=>255, :null=>false
      table.column :test_link_id, :integer, :null=>true
      table.column :setup_script, :text, :null=>true
      table.column :teardown_script, :text, :null=>true
      table.column :execute_script, :text, :null=>false
      table.column :created_on, :datetime, :null=>false, :default=>Time.now
    end
  end

  def self.down
    drop_table :test_cases
  end
end
