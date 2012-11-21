class ApplicationController < ActionController::Base
  protect_from_forgery

  def body_class
    controller_name
  end
end
