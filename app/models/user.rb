class User < ActiveRecord::Base
  attr_accessible :email

  validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false }

  def self.authenticate(email)
    user = find_by_email(email)
    return user
  end

end
