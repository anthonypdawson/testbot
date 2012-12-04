class AddProjectTable < ActiveRecord::Migration
  def self.up
    create_table :projects do |table|
	table.column :name, :string, :limit => 255, :null => false
        table.column :created_on, :datetime, :null=> false, :default=>Time.now
    end
  end

  def self.down
    drop_table :projects
  end
end
