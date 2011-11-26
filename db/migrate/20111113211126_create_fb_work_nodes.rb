class CreateFbWorkNodes < ActiveRecord::Migration
  def change
    create_table :fb_work_nodes do |t|
      t.string :employer
      t.string :position
      t.string :location
      t.string :start_date
      t.string :end_date
      t.integer :fb_user_node_id
      t.boolean :show
      t.timestamps
    end
  end
end
