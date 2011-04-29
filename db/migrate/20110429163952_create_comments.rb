class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :content
      t.integer :commenter_id
      t.integer :link_id
      t.integer :parent_id

      t.timestamps
    end
    
    add_index :comments, :link_id
  end
  
  def self.down
    drop_table :comments
  end
end
