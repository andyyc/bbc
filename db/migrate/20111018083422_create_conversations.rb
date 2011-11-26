class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :link_id

      t.timestamps
    end
  end
end
