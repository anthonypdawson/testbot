class AddTestToTse < ActiveRecord::Migration
  def self.up
    add_column :test_suite_executions, :is_test, :boolean, :default=>false, :null=>false
  end

  def self.down
    remove_column :test_suite_executions, :is_test
  end
end
