class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.string :url
      t.string :headline
      t.integer :submitter_id
      t.integer :score

      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
