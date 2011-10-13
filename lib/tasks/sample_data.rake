namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    10.times do
      User.all(:limit => 6).each do |user|
        user.links.create!(:url => "www.google.com")
      end                     
    end       
  end
end