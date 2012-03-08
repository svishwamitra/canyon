class DashboardController < ApplicationController
  # GET /
  # The default dashboard
  def index
    render :layout => "landing"
  end

#  def logo
#	@images = Image.all(:conditions => ["image_type = ?", "Logo"])
#  end
#
#  def print_design
#	@images = Image.all(:conditions => ["image_type = ?", "Print Design"])
#  end
  
  def contact_us
	  render :layout => "landing"
  end

  def about_us
  end

  def services
  end

  def clients
  end

  def apply_now
    #render :layout => "landing"
  end

  def applyform
	  apl = params[:apply]
    name = apl[:name]
	  address = apl[:address]
	  tel_mobile = apl[:tel_mobile]
	  email = apl[:email]
	  about = apl[:about]

    UserMailer.deliver_aplnow(name, address, tel_mobile, email, about)
    return if request.xhr?
		flash[:notice] = 'Application Form was filled successfully!!!.'
		redirect_to root_path
  end

  def contactform
	  cont = params[:contact]
    name = cont[:name]
	  address = cont[:address]
	  tel_mobile = cont[:tel_mobile]
	  email = cont[:email]
	  enquiry = cont[:enquiry]

    UserMailer.deliver_contactf(name, address, tel_mobile, email, enquiry)
	  #puts "=.......................................=..........what is happening?"
    return if request.xhr?
		flash[:notice] = 'Contact form was filled successfully!!!.'
		redirect_to root_path
   end

end
