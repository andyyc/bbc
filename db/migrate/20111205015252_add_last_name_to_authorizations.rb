class AddLastNameToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :last_name, :string
  end
end
