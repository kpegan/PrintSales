class Job < ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  belongs_to :staff, :class_name => "User", :foreign_key => "staff_id"
  
  def print_cost
    #area in square feet
    paper_area = (paper_width * paper_height) / 144
    image_area = (image_width * image_height) / 144
    
    print_cost = paper_area * paper_price + image_area * ink_price
  end
  
  def status
    unless paid.nil?
      status = "Paid on " + paid.strftime("%m/%d/%Y")
    else
      unless printed.nil?
        status = "Printed on " + printed.strftime("%m/%d/%Y")
      else
        unless created_at.nil?
          status = "Requested on " + created_at.strftime("%m/%d/%Y")
        else
          status = "Not available"
        end
      end
    end
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
end
