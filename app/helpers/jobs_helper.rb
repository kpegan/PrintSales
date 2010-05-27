module JobsHelper
  def current_paper_price
    1.5
  end
  
  def current_ink_price
    2
  end
  
  def image_dimensions job
    @job.nil? ? "" : "#{job.image_width} x #{job.image_height} inches"
  end
  
  def paper_dimensions job
    @job.nil? ? "" : "#{job.paper_width} x #{job.paper_height} inches"
  end
  
end