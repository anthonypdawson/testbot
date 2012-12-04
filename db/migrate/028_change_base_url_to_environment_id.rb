class ChangeBaseUrlToEnvironmentId < ActiveRecord::Migration
  def self.up
    remove_column :test_suite_executions, :base_url
    add_column :test_suite_executions, :environment_id, :integer, :null=>false
  end

  def self.down
    remove_column :test_suite_executions, :environment_id
    add_column :test_suite_executions, :base_url, :string, :limit=>255, :null=>false
  end
end
