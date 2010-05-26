class Job < ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  belongs_to :staff, :class_name => "User", :foreign_key => "staff_id"
  
  validates_presence_of     :file
  
  def paper_area 
    (paper_width * paper_height) / 144
  end
  
  def image_area
    (image_width * image_height) / 144
  end
  
  def print_cost
    print_cost = paper_area * paper_price + image_area * ink_price
  end
  
  def total
    unless quantity.nil? or print_cost.nil?
      total = print_cost * quantity
    end
  end
  
  def discounted_total
    unless discount.nil?
      total * (1 - discount)
    else
      total
    end
  end
  
  def status
    unless paid_at.nil?
      status = "paid"
    else
      unless printed_at.nil?
        status = "printed"
      else
        unless created_at.nil?
          status = "requested"
        else
          status = ""
        end
      end
    end
  end
  
  def status_date
    unless paid_at.nil?
      status = "Paid on " + paid_at.strftime("%m/%d/%Y")
    else
      unless printed_at.nil?
        status = "Printed on " + printed_at.strftime("%m/%d/%Y")
      else
        unless created_at.nil?
          status = "Requested on " + created_at.strftime("%m/%d/%Y")
        else
          status = "Not available"
        end
      end
    end
  end
  
  
end
