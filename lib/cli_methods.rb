require_relative '../config/environment'

def welcome
  puts "Welcome to StatTracker"
  puts "Are you a new user? (Y/N)"
end

def wrong_login_prompt
  puts "Username not found: Please try again (cap sensitive)"
  puts "Would you like to create a new user? (Y/N) or Quit (Q)"
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

def look_for_user
  puts "Enter your username"
  username = gets.chomp
  User.all.find_by({username: username})
end

def display_menu(user)
  puts "Welcome #{user.username}"
  puts "Display Menu (Choose your option)"
  puts "1 - Add Game"
  puts "2 - Update Previous Game Stats"
  puts "3 - Explore Stats"
  puts "4 - Quit"
end
