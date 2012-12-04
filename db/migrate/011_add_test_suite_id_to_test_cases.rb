class AddTestSuiteIdToTestCases < ActiveRecord::Migration
  def self.up
    add_column :test_cases, :test_suite_id, :integer, :null=>true
  end

  def self.down
    delete_column :test_cases, :test_suite_id
  end
end
