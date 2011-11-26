class FbUserWorkNode < ActiveRecord::Base
  belongs_to :user_node
  belongs_to :work_node
end
