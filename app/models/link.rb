class Link < ActiveRecord::Base
  attr_accessible :url
  
  belongs_to :user

  validates :url, :presence => true
  validates :user_id, :presence => true

  default_scope :order => 'links.created_at DESC'
end
