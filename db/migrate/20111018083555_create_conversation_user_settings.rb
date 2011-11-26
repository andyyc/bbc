class CreateConversationUserSettings < ActiveRecord::Migration
  def change
    create_table :conversation_user_settings do |t|
      t.integer :conversation_id
      t.integer :user_id

      t.timestamps
    end
  end
end
