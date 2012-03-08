class UserMailer < ActionMailer::Base
  def aplnow(name, address, tel_mobile, email, about)
    @name = name
    @address = address
    @tel_mobile = tel_mobile
    @recipients = 'jobs@canyon.in'
    @sent_on = Time.now
    @from = email
    @about = about
    subject "Application form filled By "+@name

    content_type "text/html"
  end
  
  def contactf(name, address, tel_mobile, email, enquiry)
    @name = name
    @address = address
    @tel_mobile = tel_mobile
    @recipients = 'info@canyon.in'
    @sent_on = Time.now
    @from = email
    @enquiry = enquiry
    subject "Contact form filled By "+@name

    content_type "text/html"
  end
  
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
    @body[:url]  = "http://#{configatron.site_url}/activate/#{user.activation_code}"
  end
  
  def reset_password(user)
    setup_email(user)
    @subject += "Your password has been reset"
    @body[:url]  = "http://#{configatron.site_url}/login"
  end
  
  def forgot_password(user)
    setup_email(user)
    @subject += "Forgotten password instructions"
    @body[:url]  = "http://#{configatron.site_url}/users/reset_password/#{user.password_reset_code}"
  end
  
  def forgot_login(user)
    setup_email(user)
    @subject += "Forgotten account login"
    @body[:url]  = "http://#{configatron.site_url}/login"
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://#{configatron.site_url}/"
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "#{configatron.support_name} <#{configatron.support_email}>"
      @subject     = "[#{configatron.site_name}] "
      @sent_on     = Time.now
      @body[:user] = user
      
      # Get Settings
      [:site_name, :company_name, :support_email, :support_name].each do |id|
        @body[id] = configatron.send(id)
      end
    end
end
