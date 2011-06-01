class Profile < ActiveRecord::Base

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  validates_presence_of :organization, :if => :entered_organization_url?
  
  def entered_organization_url?
    organization_url.present?
  end
  
end
