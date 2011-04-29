class Vote < ActiveRecord::Base
  attr_accessible :votable_id, :votable_type, :voter_id
  
  belongs_to :votable, :polymorphic => true
  belongs_to :voter, :class_name => "User"
end
