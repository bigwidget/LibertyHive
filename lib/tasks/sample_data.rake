require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_links
    make_votes
    make_comments
  end
end

def make_users
  # admin = User.create!(:name => "Example User",
  #              :email => "example@railstutorial.org",
  #              :password => "foobar",
  #              :password_confirmation => "foobar")
  # admin.toggle!(:admin)
  
  tim = User.create!(:email => "tim@mytype.com",
               :password => "mytype",
               :password_confirmation => "mytype")
  tim.build_profile(:first_name => "Tim", :last_name => "Koelkebeck")
  tim.save
  
  99.times do |n|
    fname = Faker::Name.first_name
    lname = Faker::Name.last_name 
    email = "example-#{n+1}@mytype.com"
    password  = "password"
    fake_user = User.create!(:email => email,
                 :password => password,
                 :password_confirmation => password)
    fake_user.build_profile(:first_name => fname, :last_name => lname)
    fake_user.save    
  end
end
    
def make_links
  users = User.all
  35.times do |n|
    user = users[n]
    url = Faker::Internet.domain_name
    headline = Faker::Lorem::sentence(2 + rand(4))
    user.links.create!(:url => url, :headline => headline)
  end
end

def make_votes
  num_users = User.all.count
  Link.all(:limit => 10).each do |link|
    rand(10).times do |vote|
      User.find(rand(num_users)+1).vote_for!(link)
    end
  end
end

def make_comments
  num_users = User.all.count
  Link.all(:limit => 10).each do |link|
    rand(10).times do |comment|
      link.comments.create!(:content => Faker::Lorem::paragraph,
                            :commenter_id => rand(num_users) + 1)
    end
  end
end