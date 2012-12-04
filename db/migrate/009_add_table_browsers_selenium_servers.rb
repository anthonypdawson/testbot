class AddTableBrowsersSeleniumServers < ActiveRecord::Migration
  def self.up
    create_table :browsers_selenium_servers, :id=> false do |table|
      table.column :browser_id, :integer, :null=>false
      table.column :selenium_server_id, :integer, :null=>false
    end
  end

  def self.down
    drop_table :browsers_selenium_servers
  end
end
