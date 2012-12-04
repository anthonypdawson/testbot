class AddTestCasesTestSuitesTable < ActiveRecord::Migration
  def self.up
    create_table :test_cases_test_suites, :id=> false do |table|
      table.column :test_case_id, :integer, :null=>false
      table.column :test_suite_id, :integer, :null=>false
    end
  end

  def self.down
    remove_table :test_cases_test_suites
  end
end
