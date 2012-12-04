class AddDescriptionToTse < ActiveRecord::Migration
  def self.up
    add_column :test_suite_executions, :description, :string, :limit=>64
  end

  def self.down
    remove_column :test_suite_execution, :description
  end
end
