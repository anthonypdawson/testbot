class ChangeVersionToRevisionId < ActiveRecord::Migration
  def self.up
    remove_column :test_suite_executions, :version
    add_column :test_suite_executions, :revision_id, :integer, :null=>false
  end

  def self.down
    remove_column :test_suite_executions, :revision_id
    add_column :test_suite_executions, :version, :string, :limit=>64, :null=>false
  end
end
