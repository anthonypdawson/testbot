class AddTestCasesTestSuiteExecutions < ActiveRecord::Migration
  def self.up
    create_table :test_cases_test_suite_executions, :id=> false do |table|
      table.column :test_case_id, :integer, :null=>false
      table.column :test_suite_execution_id, :integer, :null=>false
    end
  end

  def self.down
    drop_table :test_cases_test_suite_executions
  end
end
