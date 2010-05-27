# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def site_title
    "Grad Print Sales"
  end
  
  def table_row(row, &block)
    buttons = ""
    buttons << content_tag(:td, check_box_tag("row_ids[]", row.id), :class=>"button")
    buttons << content_tag(:td, link_to(image_tag("show.png", :border=>0), row), :class=>"button")
    buttons << content_tag(:td, link_to(image_tag("edit.png", :border=>0), job_edit_path), :class=>"button")
    buttons << content_tag(:td, link_to(image_tag("delete.png", :border=>0), row, :confirm => 'Are you sure?', :method => :delete), :class=>"button")
    
    row = buttons + capture(&block)
    concat content_tag(:tr, row, :class=>cycle("odd", "even")), block.binding
  end
end
