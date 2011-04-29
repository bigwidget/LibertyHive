class Link < ActiveRecord::Base
  attr_accessible :url, :headline

  belongs_to :user
  has_many :votes, :as => :votable                  #### TRY REMOVING FOREIGN KEY
  has_many :comments, :foreign_key => "link_id"     #### SPECIFICATIONS

end
