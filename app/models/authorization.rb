class Authorization < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_from_hash(hash)
    authorization = find_by_provider_and_uid(hash['provider'], hash['uid'])
    return authorization
  end

  def self.create_from_hash(hash, user = nil, token = nil)
    user = User.find_by_email(hash['info']['email'])
    if user.nil?
      user = User.create_from_hash!(hash)
    end
    Authorization.create(:user => user, :uid => hash['uid'], :provider => hash['provider'], :token => hash['credentials']['token'], :first_name => hash['info']['first_name'], :last_name => hash['info']['last_name'], :name => hash['info']['name'], :nickname => hash['info']['nickname'])
  end

  def update_from_hash(hash)
    self.token = hash['credentials']['token']
    self.first_name = hash['info']['first_name']
    self.last_name = hash['info']['last_name']
    self.name = hash['info']['name']
    self.nickname = hash['info']['nickname']
    self.save()
  end
end
