require_relative '../config/environment'

welcome
new_user = gets.chomp.downcase

if new_user == "y"
  create_new_user
else new_user == "n"
  puts "lots of other stuff"
end
