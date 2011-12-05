class AddFirstNameToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :first_name, :string
  end
end
