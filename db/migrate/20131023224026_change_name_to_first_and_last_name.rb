class ChangeNameToFirstAndLastName < ActiveRecord::Migration
  def up
    remove_column :users, :name
    add_column :users, :first_name
    add_column :users, :last_name
  end

  def down
    remove_column :users, :first_name
    remove_column :users, :last_name
    add_column :users, :name
  end
end
