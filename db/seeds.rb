User.create!([
  { email: 'administrator@user.com', password: '12345678', full_name: 'Admin User', role: 0 },
  { email: 'common_user@user.com', password: '12345678', full_name: 'Common User' },
  { email: 'other@user.com', password: '12345678', full_name: 'Other User' }
])
