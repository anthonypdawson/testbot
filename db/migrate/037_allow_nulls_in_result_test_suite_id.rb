class AllowNullsInResultTestSuiteId < ActiveRecord::Migration
  def self.up
    change_column :results, :test_suite_id, :integer, :default=>nil, :null=>true
  end

  def self.down
    change_column :results, :test_suite_id, :integer, :null=>false
  end
end
