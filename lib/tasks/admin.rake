namespace :admin do


  task :create => :environment do
    u = User.new
    STDOUT.puts "Create an admin user."
    STDOUT.puts "Type the admin email."
    u.email = STDIN.gets.chomp
    STDOUT.puts "Type the admin password."
    u.password = STDIN.gets.chomp
    u.first_name = "Admin"
    u.last_name = "User"
    u.address = "Some address"
    u.city = "City"
    u.state = "State"
    u.zipcode = "42321"
    u.add_role :admin
    u.save
  end

  task :recipe => :environment do
    puts "Creating recipe for this month"
    Recipe.find_or_create_by_month_and_year(
      name: "Seasonal Ale",
      description: "This recipe is great!  It is perfect for this season!",
      month: Date.today.month,
      year: Date.today.year,
      deadline: 20
    )
  end

  task :init => [:create, :recipe]

end
