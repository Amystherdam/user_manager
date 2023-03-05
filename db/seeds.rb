User.create!([
  { email: 'common_user@user.com', password: '12345678', full_name: 'Common User' },
  { email: 'administrator@user.com', password: '12345678', full_name: 'Admin User', role: 0 }
])
