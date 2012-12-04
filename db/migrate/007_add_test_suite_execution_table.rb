class AddTestSuiteExecutionTable < ActiveRecord::Migration
  def self.up
    create_table :test_suite_executions do |table|
      table.column :base_url, :string, :limit=>255, :null=>false
      table.column :status, :string, :limit=>1, :null=>false, :default=>'n'
      table.column :created_on, :datetime, :null=>false, :default=>Time.now
    end
  end

  def self.down
    drop_table :test_suite_executions
  end
end
