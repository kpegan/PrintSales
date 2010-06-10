module JobsHelper
  def image_dimensions job
    @job.nil? ? "" : "#{job.image_width} x #{job.image_height} inches"
  end
  
  def paper_dimensions job
    @job.nil? ? "" : "#{job.paper_width} x #{job.paper_height} inches"
  end
  
end