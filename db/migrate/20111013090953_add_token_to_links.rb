class AddTokenToLinks < ActiveRecord::Migration
  def change
    add_column :links, :token, :string
  end
end
