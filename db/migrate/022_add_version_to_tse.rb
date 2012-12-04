class AddVersionToTse < ActiveRecord::Migration
  def self.up
    add_column :test_suite_executions, :version, :string, :null=>false
  end

  def self.down
    remove_column :test_suite_executions, :version
  end
end
