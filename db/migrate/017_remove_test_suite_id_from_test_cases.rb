# This migration will destroy any TestSuite <-> TestCase relationships!
class RemoveTestSuiteIdFromTestCases < ActiveRecord::Migration
  def self.up
    remove_column :test_cases, :test_suite_id
  end

  def self.down
  end
end
