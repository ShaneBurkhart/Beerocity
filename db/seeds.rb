# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
puts 'ROLES'
# YAML.load(ENV['ROLES']).each do |role|
["basic", "admin"].each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.find_or_create_by_email :first_name => "Shane", :last_name => "Burkhart", :email => ENV["ADMIN_EMAIL"], :password => ENV["ADMIN_PASSWORD"], :password_confirmation => ENV["ADMIN_PASSWORD"], address: "111 First St.", city: "Rolla", state: "Missouri", zipcode: "65401", stripe_token: "asdfasdfasdfasdf"
user.add_role :admin

Recipe.find_or_create_by_month_and_year(
  month: Date.today.month,
  year: Date.today.year,
  name: "Gingerbread Ale",
  description: "Gingerbread Ale That is great!!!",
  deadline: "20",
  image: "Some image"
)
