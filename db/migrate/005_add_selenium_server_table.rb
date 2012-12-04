class AddSeleniumServerTable < ActiveRecord::Migration
  def self.up
    create_table :selenium_servers do |table|
      table.column :name, :string, :limit=>255, :null=>false
      table.column :host_name, :string, :limit=>255, :null=>false
      table.column :port, :integer, :null=>false, :default=>4444
      table.column :created_on, :datetime, :null=>false, :default=>Time.now
    end
  end

  def self.down
    drop_table :selenium_servers
  end
end
