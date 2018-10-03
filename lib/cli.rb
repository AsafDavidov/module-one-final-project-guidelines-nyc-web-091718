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



option_choice = 7
while option_choice != 4
  display_menu(current_user)
  option_choice = gets.chomp.to_i
  if option_choice == 4
    puts "Goodbye!"
    abort
  elsif option_choice == 1
    add_user_game(current_user)
  elsif option_choice == 2
    update_user_stats(current_user)
  elsif option_choice == 3
    display_option = 7
    while display_option != 4
      display_stat_menu
      display_option = gets.chomp.to_i
      if display_option == 4
        puts "Returning to the Menu Main"
      elsif display_option == 1
        specifc_game_stats(current_user)
      elsif display_option == 2
        average_stats(current_user)
      elsif display_option == 3
        lifetime_stats(current_user)
      else
        puts "Invalid input"
      end
    end
  else
    puts "Invalid input"
  end
end
