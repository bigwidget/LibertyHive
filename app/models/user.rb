class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_many :links, :foreign_key => "submitter_id"
  has_many :votes, :foreign_key => "voter_id"
  has_many :comments, :foreign_key => "commenter_id"
    
  #need to do profile model http://stackoverflow.com/questions/4307743/profile-model-for-devise-users
  
  def name
    fname + " " + lname
  end
  
end
