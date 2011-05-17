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
  
end
