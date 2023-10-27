class ApplicationController < ActionController::Base
  helper_method :currentuser

  def currentuser
    User.first
  end
end
