class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.string :user_id
      t.string :staff_id
      t.string :file
      t.float :paper_width
      t.float :paper_height
      t.float :image_width
      t.float :image_height
      t.decimal :paper_price
      t.decimal :ink_price
      t.integer :quantity
      t.integer :discount
      t.timestamp :printed
      t.timestamp :paid

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
