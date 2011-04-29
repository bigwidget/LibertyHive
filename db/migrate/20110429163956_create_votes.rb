class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :voter_id
      t.integer :votable_id
      t.string :votable_type

      t.timestamps
    end

    add_index :votes, :votable_id
    add_index :votes, [:voter_id, :votable_id], :unique => true
  end
  
  def self.down
    drop_table :votes
  end
end
