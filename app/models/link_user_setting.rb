class LinkUserSetting < ActiveRecord::Base
  belongs_to :link
  belongs_to :user
  validates_presence_of :name
  has_one :fb_user_node
  def name
    if self[:name].nil?
      return "Anonymous"
    else
      return self[:name]
    end
  end
end
