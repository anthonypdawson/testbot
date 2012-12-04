class AddEnvironment < ActiveRecord::Migration
  def self.up
    create_table :environments do |table|
      table.column :name, :string, :limit => 255, :null=> false
      table.column :project_id, :integer, :null => false
      table.column :base_url, :string, :limit => 255, :null=>false
      table.column :is_current, :boolean, :default=> 1, :null=>false
      table.column :created_on, :datetime, :null=>false
    end
  end

  def self.down
    drop_table :environments
  end
end
