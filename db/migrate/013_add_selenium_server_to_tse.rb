class AddSeleniumServerToTse < ActiveRecord::Migration
  def self.up
    add_column :test_suite_executions, :selenium_server_id, :integer, :null=>false
  end

  def self.down
    remove_column :test_suite_executions, :selenium_server_id
  end
end
