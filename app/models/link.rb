class Link < ActiveRecord::Base
  attr_accessible :url, :headline

  belongs_to :submitter, :class_name => 'User'
  has_many :votes, :as => :votable                  #### TRY REMOVING FOREIGN KEY
  has_many :comments, :foreign_key => "link_id"     #### SPECIFICATIONS

  validates :url,       :presence   => true,
                        :uniqueness => true,
                        :uri => { :format => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix }

  validates :headline,  :presence   => true,
                        :length     => { :maximum => 80 }
  
  validates :score,     :presence   => true
    
  before_validation_on_create :initialize_score
  #### DEPRECATION WARNING: before_validation_on_create is deprecated. Please use before_validation(arguments, :on => :create.
  
  def initialize_score
    self.score = 0
  end
  
  def update_score
    unless votes.count.nil?
      self.score = votes.count
      self.save
    end
    #hacker news: votes / (hours + 2)**g, g is 1.8
  end
  
  def hours_ago
    (Time.now - created_at) / 3600
  end
  
  def full_url
    "http://" + url
  end
  
  def domain
    URI.parse(url).host.sub(/\Awww\./, '')
  end
  
  def domain_paren
    "(" + domain + ")"
  end
  
  default_scope :order => 'links.score DESC'
end
