class AddProjectIdToTestSuites < ActiveRecord::Migration
  def self.up
    add_column :test_suites, :project_id, :integer, :null=>true
  end

  def self.down
    delete_column :test_suites, :project_id
  end
end
