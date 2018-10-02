require_relative '../config/environment'

def welcome
  puts "Welcome to StatTracker"
  puts "Are you a new user? (Y/N)"
end

def create_new_user
  puts "Please provide the following information"
  puts "First Name"
  new_user_first_name = gets.chomp
  puts "Last Name"
  new_user_last_name = gets.chomp
  puts "Username (Must be unique!)"
  new_user_username = gets.chomp
  while check_for_unique_username(new_user_username) != nil
    puts "Username has been taken! Be more unique!"
    new_user_username = gets.chomp
  end
  User.create({first_name:new_user_first_name, last_name:new_user_last_name, username: new_user_username})
end

def check_for_unique_username(username)
  User.all.find_by(username: username)
end
