class FbUserNode < ActiveRecord::Base
  has_many :fb_work_nodes
  has_many :fb_education_nodes
  belongs_to :link_user_setting
end
