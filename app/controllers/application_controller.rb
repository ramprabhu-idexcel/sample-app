class ApplicationController < ActionController::Base  
  protect_from_forgery  
  include SessionsHelper
  include ErrorsHelper::RescueError 

  # Customize the Devise after_sign_in_path_for() for redirecct to previous page after login
  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope
    when :user, User
      store_location = session[:return_to]
      puts store_location.inspect
      clear_stored_location
      (store_location.nil?) ? "/ideas" : store_location.to_s
    else
      super
    end
  end 
end
