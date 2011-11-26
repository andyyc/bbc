class Message < ActiveRecord::Base
  attr_accessible :body, :subject
  belongs_to :conversation
  belongs_to :user
  default_scope :order => 'messages.updated_at'
  validates_presence_of :body
end
