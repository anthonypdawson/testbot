class AddRevision < ActiveRecord::Migration
  def self.up
    create_table :revisions do |table|
      table.column :version, :string, :limit=>255, :null=>false
      table.column :project_id, :integer, :null=>false
      table.column :created_on, :datetime, :null=> false
      table.column :is_current, :boolean, :null=> false, :default=> 1
    end
  end

  def self.down
    drop_table :revisions
  end
end
