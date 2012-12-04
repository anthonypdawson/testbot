class AddStartAndCompleteDatesToTse < ActiveRecord::Migration
  def self.up
    add_column :test_suite_executions, :started_on, :datetime
    add_column :test_suite_executions, :completed_on, :datetime
  end

  def self.down
    delete_column :test_suite_executions, :started_on
    delete_column :test_suite_executions, :completed_on
  end
end
