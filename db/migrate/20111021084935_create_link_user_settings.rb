class CreateLinkUserSettings < ActiveRecord::Migration
  def change
    create_table :link_user_settings do |t|
      t.integer :link_id
      t.integer :user_id
      t.string :name
      t.timestamps
    end
  end
end
