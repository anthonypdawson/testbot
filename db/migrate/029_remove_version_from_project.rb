class RemoveVersionFromProject < ActiveRecord::Migration
  def self.up
    remove_column :projects, :version
  end

  def self.down
    add_column :projects, :version, :string, :limit=>64
  end
end
