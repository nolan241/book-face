class ApplicationController < ActionController::Base
  
  #get friend count in the nav
  helper_method :request_count
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def request_count
    #request users count under the people filter buttons
    current_user.pending_friend_requests_from.map(&:user).size
  end
  
end
