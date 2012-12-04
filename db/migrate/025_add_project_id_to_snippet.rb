class AddProjectIdToSnippet < ActiveRecord::Migration
  def self.up
    add_column :snippets, :project_id, :integer, :null=>true
  end

  def self.down
    remove_column :snippets, :project_id
  end
end
