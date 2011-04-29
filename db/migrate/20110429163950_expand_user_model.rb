class ExpandUserModel < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :fname
      t.string :lname
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
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :fname
      t.remove :lname
      t.remove :about
      t.remove :city
      t.remove :occupation
      t.remove :organization
      t.remove :organization_url
      t.remove :linkedin_url
      t.remove :facebook_url
      t.remove :twitter_url
      t.remove :blog_url
      t.remove :personal_url
      t.remove :email_public
    end
  end
end
