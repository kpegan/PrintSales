class Job < ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  belongs_to :staff, :class_name => "User", :foreign_key => "staff_id"
  
  validates_presence_of  :file
  
  def paper_area
    if paper_width.nil? or paper_height.nil?
      0
    else
      (paper_width * paper_height) / 144
    end
  end
  
  def paper_cost
    paper_area * paper_price
  end
  
  def ink_cost
    image_area * ink_price
  end
  
  def image_area
    if image_width.nil? or image_height.nil?
      0
    else
      (image_width * image_height) / 144
    end
  end
  
  def print_cost
    print_cost = paper_cost + ink_cost
  end
  
  def total
    unless quantity.nil? or print_cost.nil?
      total = print_cost * quantity
    end
  end
  
  def discounted_total
    unless discount.nil?
      total - (total * discount / 100)
    else
      total
    end
  end
  
  def status new_status = nil
    #check or update the current status
    case new_status
      when nil
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
      when :requested
        write_attribute(:printed_at, nil)
        write_attribute(:paid_at, nil)
        "requested"
      when :printed
        write_attribute(:printed_at, Time.now) if printed_at.nil?
        write_attribute(:paid_at, nil)
        "printed"
      when :paid
        write_attribute(:printed_at, Time.now) if printed_at.nil?
        write_attribute(:paid_at, Time.now)
        "paid"
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
