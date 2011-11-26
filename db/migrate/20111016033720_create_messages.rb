class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :subject
      t.string :body
      t.integer :conversation_id
      t.integer :user_id

      t.timestamps
    end
  end
end
