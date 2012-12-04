class CreateSnippets < ActiveRecord::Migration
  def self.up
    create_table :snippets do |t|
      t.column :name, :string, :null=>false, :limit=>64
      t.column :script, :text, :null=>false
    end
  end

  def self.down
    drop_table :snippets
  end
end
