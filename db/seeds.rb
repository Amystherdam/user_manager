puts 'Creating users...'
15.times do |i|
  role = i.zero? ? 0 : 1
  full_name = Faker::Name.name

  User.create!(
    full_name:,
    email: Faker::Internet.email(
      name: full_name,
      domain: 'user',
      separators: '_'
    ),
    password: '12345678',
    role:
  )
end
puts 'Finshed creation...'
