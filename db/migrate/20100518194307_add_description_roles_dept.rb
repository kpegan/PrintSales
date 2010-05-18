class AddDescriptionRolesDept < ActiveRecord::Migration
  def self.up
    add_column :roles, :description, :string
    add_column :departments, :description, :string
  end

  def self.down
    drop_column :roles, :description, :string
    drop_column :departments, :description, :string   
  end
end
