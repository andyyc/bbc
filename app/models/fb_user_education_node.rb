class FbUserEducationNode < ActiveRecord::Base
  belongs_to :fb_user_node
  belongs_to :fb_education_node
end
