class AddIsActiveToSeleniumServer < ActiveRecord::Migration
  def self.up
    add_column :selenium_servers, :is_active, :boolean, :default => 1, :null=> false
  end

  def self.down
    remove_column :selenium_servers, :is_active
  end
end
