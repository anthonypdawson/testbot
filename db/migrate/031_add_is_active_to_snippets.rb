class AddIsActiveToSnippets < ActiveRecord::Migration
  def self.up
    add_column :snippets, :is_active, :boolean, :default=>1, :null=>false
  end

  def self.down
    remove_column :snippets, :is_active
  end
end
