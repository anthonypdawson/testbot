class AddSeleniumNameToBrowsers < ActiveRecord::Migration
  def self.up
    add_column :browsers, :selenium_name, :string, :limit=>255, :null=>false  
  end

  def self.down
    delete_column :browsers, :selenium_name
  end
end
