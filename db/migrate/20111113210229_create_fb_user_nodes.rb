class CreateFbUserNodes < ActiveRecord::Migration
  def change
    create_table :fb_user_nodes do |t|
      t.string :id
      t.string :picture
      t.string :name
      t.string :link
      t.string :username
      t.string :gender
      t.string :email
      t.string :verified
      t.string :updated_time
      t.string :hometown
      t.string :location
      t.boolean :show_picture
      t.boolean :show_name
      t.boolean :show_gender
      t.boolean :show_hometown
      t.boolean :show_location
      t.integer :link_user_setting_id
      t.timestamps
    end
  end
end
