# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Account.create({email: 'admin@example.com', password: 'password', role: 'admin'})
ShowingTimeSlot.find_or_create_by(start_time: Time.parse("10:00").strftime("%I:%M %p"), end_time: Time.parse("12:00").strftime("%I:%M %p"))
ShowingTimeSlot.find_or_create_by(start_time: Time.parse("12:00").strftime("%I:%M %p"), end_time: Time.parse("14:00").strftime("%I:%M %p"))
ShowingTimeSlot.find_or_create_by(start_time: Time.parse("14:00").strftime("%I:%M %p"), end_time: Time.parse("17:00").strftime("%I:%M %p"))
