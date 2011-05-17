class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.text :about
      t.string :city
      t.string :occupation
      t.string :organization
      t.string :organization_url
      t.string :linkedin_url
      t.string :facebook_url
      t.string :twitter_url
      t.string :blog_url
      t.string :personal_url
      t.boolean :email_public

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
