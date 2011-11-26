class Link < ActiveRecord::Base
  attr_accessible :url
  has_many :conversations
  
  has_many :link_user_settings
  has_many :users, :through => :link_user_settings
  
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"

  validates :url, :presence => true
  validates :owner_id, :presence => true

  default_scope :order => 'links.created_at DESC'

  before_save :create_token
  
  private
  
  def create_token
    self.token = (0...6).map{ ('a'..'z').to_a[rand(26)] }.join
  end

end
