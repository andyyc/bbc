class Conversation < ActiveRecord::Base
  has_many :conversation_user_settings
  has_many :users, :through => :conversation_user_settings
  belongs_to :link
  has_many :messages
  
  belongs_to :visitor, :class_name => "User", :foreign_key => "visitor_id"
  
  def get_other_user(current_user)
    other_user = nil
    for conv_user in self.users
      if conv_user != current_user
        other_user = conv_user
        break
      end
    end
    return other_user
  end
end
