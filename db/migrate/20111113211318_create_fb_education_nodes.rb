class CreateFbEducationNodes < ActiveRecord::Migration
  def change
    create_table :fb_education_nodes do |t|
      t.string :school
      t.string :year
      t.string :school_type
      t.string :degree
      t.integer :fb_user_node_id
      t.boolean :show
      t.timestamps
    end
  end
end
