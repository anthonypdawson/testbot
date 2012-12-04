class AddIsActiveToTestSuites < ActiveRecord::Migration
  def self.up
    add_column :test_suites, :is_active, :boolean, :default=>1, :null=>false
  end

  def self.down
    remove_column :test_suites, :is_active
  end
end
