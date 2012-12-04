class AddVersionToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :version, :string, :null=>false
  end

  def self.down
    remove_column :projects, :version
  end
end
