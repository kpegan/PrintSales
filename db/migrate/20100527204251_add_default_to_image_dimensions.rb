class AddDefaultToImageDimensions < ActiveRecord::Migration
  def self.up
    change_column :jobs, :paper_width, :float, :default => "0"
    change_column :jobs, :paper_height, :float, :default => "0"
    change_column :jobs, :image_width, :float, :default => "0"
    change_column :jobs, :image_height, :float, :default => "0"
    change_column :jobs, :paper_price, :decimal, :default => "0"
    change_column :jobs, :ink_price, :decimal, :default => "0"
    change_column :jobs, :quantity, :integer, :default => "0"
  end

  def self.down
    change_column :jobs, :paper_width, :float, :default => ""
    change_column :jobs, :paper_height, :float, :default => ""
    change_column :jobs, :image_width, :float, :default => ""
    change_column :jobs, :image_height, :float, :default => ""
    change_column :jobs, :paper_price, :decimal, :default => ""
    change_column :jobs, :ink_price, :decimal, :default => ""
    change_column :jobs, :quantity, :integer, :default => ""
  end
end
