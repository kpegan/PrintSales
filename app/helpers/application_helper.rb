# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def site_title
    "Grad Print Sales"
  end
  
  def listAandR(action = action_name, resource = nil)
      "Action: " + action_name + "  Resource: " + resource
  end
end
