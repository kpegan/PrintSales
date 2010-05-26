class RenameJobsPrintedPaid < ActiveRecord::Migration
  def self.up
    rename_column :jobs, :printed, :printed_at 
    rename_column :jobs, :paid, :paid_at 
  end

  def self.down
    rename_column :jobs, :printed_at, :printed
    rename_column :jobs, :paid_at, :paid
  end
end
