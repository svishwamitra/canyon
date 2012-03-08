# Email settings
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.arvindsingh.in',
  :port           => 25,
  :domain         => 'arvindsingh.in',
  :authentication => :login,
  :user_name      => 'info@arvindsingh.in',
  :password       => 'evershine'
 }
