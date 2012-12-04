class AddBrowserTable < ActiveRecord::Migration
  def self.up
    create_table :browsers do |table|
      table.column :name, :string, :limit=>255, :null=>false
      table.column :path, :string, :limit=>255, :null=>true
      table.column :created_on, :datetime, :default=>Time.now
    end
  end

  def self.down
    drop_table :browsers
  end
end
