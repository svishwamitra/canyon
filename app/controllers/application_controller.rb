# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include RoleRequirementSystem
  
  helper :all # include all helpers, all the time
  filter_parameter_logging :password, :password_confirmation
  
  # Return the value for a given setting
  def s(identifier)
    Setting.get(identifier)
  end
  helper_method :s, :admin?
 
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '9fe6825f97cc334d88925fde5c4808a8'

  def admin?
    admin_id = Role.find_by_name('admin').id
    if logged_in? && current_user.role_id.to_i == admin_id.to_i
      true
    else
      false
    end
  end

  def authorize
	  unless admin?
	  flash[:notice] = "Unauthorized access"
	  redirect_to root_path
	  end
  end

end
