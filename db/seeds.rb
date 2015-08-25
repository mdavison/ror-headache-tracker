# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(email: "example@example.com",
             password: "password1234",
             password_confirmation: "password1234",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

9.times do |n|
  email = "example-#{n}@example.com"
  password = "password1234"
  User.create!(email: email, 
               password: password, 
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do 
  headache_date = Faker::Time.backward(30)
  users.each { |user| user.headaches.create!(headache_date: headache_date) }
end