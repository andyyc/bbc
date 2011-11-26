class AddVisitorIdToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :visitor_id, :integer
  end
end
