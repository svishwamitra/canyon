# Create admin role and user
  admin_role = Role.create(:name => 'admin')
  
  u = User.new
  u.login = 'admin'
  u.password = u.password_confirmation = 'admin123'
  u.email = 'nospam@example.com'
  u.state = 'active'
  u.role_id = admin_role.id
  u.save!  
