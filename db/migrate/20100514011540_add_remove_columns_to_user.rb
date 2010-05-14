class AddRemoveColumnsToUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :name
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone_id, :string
    add_column :users, :role_id, :string
    add_column :users, :department_id, :string
    add_column :users, :position_id, :string
  end

  def self.down
    remove_column :users, :position_id
    remove_column :users, :department_id
    remove_column :users, :role_id
    remove_column :users, :phone_id
    remove_column :users, :last_name
    remove_column :users, :first_name
    add_column :users, :name, :string
  end
end
