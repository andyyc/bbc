require 'digest'
class User < ActiveRecord::Base
  attr_accessible :email

  validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false }
  
  before_save :set_salt
  
  has_many :authorizations
  has_many :messages, :dependent => :destroy
  has_many :conversation_user_settings
  has_many :conversations, :through => :conversation_user_settings
  has_many :link_user_settings
  has_many :links, :through => :link_user_settings

  def self.authenticate(email)
    user = find_by_email(email)
    return user
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def feed
    Link.where("owner_id = ?", id)
  end
  
  private
  
  def set_salt
    self.salt = make_salt
  end
  
  def make_salt
    secure_hash("#{Time.now.utc}")
  end
  
  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

  def self.create_from_hash!(hash)
    create(:email => hash['user_info']['email'])
  end
  
end
