class AddProjectIdToTestCases < ActiveRecord::Migration
  def self.up
    add_column :test_cases, :project_id, :integer, :null=>false    
  end

  def self.down
    remove_column :test_cases, :project_id
  end
end
