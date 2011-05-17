class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :profile_attributes
  
  has_one :profile
  accepts_nested_attributes_for :profile
  
  has_many :links, :foreign_key => "submitter_id"
  has_many :votes, :foreign_key => "voter_id"
  has_many :comments, :foreign_key => "commenter_id"
        
  def name
    profile.first_name + " " + profile.last_name
  end
  
  def karma
    vote_total(links) + vote_total(comments) + 1
  end
  
  def vote_for!(votable) 
    unless ineligible_to_vote_for? votable
      votes.create!(:votable_id => votable.id,
                    :votable_type => votable.class.name)
      votable.update_score  if votable.class.name == "Link"
    end
  end
  
  def ineligible_to_vote_for?(votable)
    already_voted_for?(votable) || is_submitter_of?(votable)
  end
  
  def is_submitter_of?(votable)
    votable.submitter.id == id
  end
  
  def already_voted_for?(votable)
    votable.votes.find_by_voter_id(id)
  end
  
  private
    
    def vote_total(votables)
      total = 0
      votables.each {|v| total += v.votes.count}
      return total
    end
  
end
