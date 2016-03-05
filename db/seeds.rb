# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

10.times do 
  user = User.new(
    #name: Faker::Name.name,
    email: Faker::Internet.free_email,
    password: Faker::Lorem.characters(8)
    )
    
  #user.skip_confirmation!
  user.save!
end

5.times do
  user = User.new(
    #name:Faker::Name.name,
    email: Faker::Internet.free_email,
    password: Faker::Lorem.characters(8),
    role: 'premium_user'
     )

  #user.skip_confirmation!
  user.save!
  end

  user = User.new(
    #name: 'Admin',
    email: 'admin@bloccit.com',
    password: 'helloworld',
    role: 'admin')

  #user.skip_confirmation!
  user.save!


 users = User.all

20.times do
  Wiki.create!(
    user: users.sample,
    title:  Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph
  )
end
 
puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"






