class AddExtraFieldsOnUser < ActiveRecord::Migration
  def up
	add_column :users, :first_name, :string
	add_column :users, :last_name, :string
	add_column :users, :phoneno, :string
	add_column :users, :age, :integer
	add_column :users, :present_address, :text
	add_column :users, :permanent_address, :text
  end

  def down
	remove_column :users, :first_name
	remove_column :users, :last_name
	remove_column :users, :phoneno
	remove_column :users, :age
	remove_column :users, :present_address
	remove_column :users, :permanent_address
  end
end
