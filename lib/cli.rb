require_relative '../config/environment'

welcome
current_user = nil


while current_user == nil
  new_user = gets.chomp.downcase
  if new_user == "y"
    current_user = create_new_user
  elsif new_user == "n"
    current_user = look_for_user
    if current_user == nil
      wrong_login_prompt
    end
  elsif new_user == "q"
    abort
  end
end



display_menu(current_user)
option_choice = gets.chomp.to_i

if option_choice == 4
  puts "Goodbye!"
  abort
elsif option_choice == 1
  add_user_game(current_user)
elsif option_choice == 2
  puts "updates avail stats"
elsif option_choice == 3
  puts "start stats"
else
  puts "invalid input"
end
