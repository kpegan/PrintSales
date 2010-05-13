class WelcomeController < ApplicationController
  def index
    @page_title = "Welcome"
    @centered = "centered"
  end
end
