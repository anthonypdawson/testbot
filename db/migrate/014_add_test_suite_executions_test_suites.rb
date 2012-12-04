class AddTestSuiteExecutionsTestSuites < ActiveRecord::Migration
  def self.up
    create_table :test_suite_executions_test_suites, :id=> false do |table|
      table.column :test_suite_execution_id, :integer, :null=>false
      table.column :test_suite_id, :integer, :null=>false
    end

  end

  def self.down
    drop_table :test_suite_executions_test_suites
  end
end
