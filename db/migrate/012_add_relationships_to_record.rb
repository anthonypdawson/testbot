class AddRelationshipsToRecord < ActiveRecord::Migration
  def self.up
    add_column :results, :test_suite_id, :integer, :null=>false
    add_column :results, :test_case_id, :integer, :null=>false
    add_column :results, :browser_id, :integer, :null=>false
    add_column :results, :test_suite_execution_id, :integer, :null=>false
  end

  def self.down
    delete_column :results, :test_suite_id
    delete_column :results, :test_case_id
    delete_column :results, :browser_id
    delete_column :results, :test_suite_execution_id
  end
end
