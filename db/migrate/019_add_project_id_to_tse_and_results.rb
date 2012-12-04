class AddProjectIdToTseAndResults < ActiveRecord::Migration
  def self.up
    add_column :test_suite_executions, :project_id, :integer, :null=>false
    add_column :results, :project_id, :integer, :null=>false
  end

  def self.down
    remove_column :test_suite_executions, :project_id
    remove_column :results, :project_id
  end
end
