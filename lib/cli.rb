require_relative '../config/environment'


current_user = nil

while current_user == nil
  welcome
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
while option_choice != 5
  current_user = User.find(current_user.id)
  #redundant?
  display_menu(current_user)
  option_choice = gets.chomp.to_i
  if option_choice == 5
    sleep(0.5)
    puts "Goodbye!"
    abort
  elsif option_choice == 1
    add_user_game(current_user)
  elsif option_choice == 2
    if current_user.has_games?
      update_user_stats(current_user)
    else
      no_games
    end
  elsif option_choice == 3
    if current_user.has_games?
      display_option = 7
      while display_option != 4
        display_stat_menu
        display_option = gets.chomp.to_i
        if display_option == 4
          sleep(0.5)
          puts "Returning to the Menu Main"
        elsif display_option == 1
          specifc_game_stats(current_user)
        elsif display_option == 2
          average_stats(current_user)
        elsif display_option == 3
          lifetime_stats(current_user)
        else
          sleep(0.2)
          puts "Invalid input"
        end
      end
    else
      no_games
    end
  elsif option_choice == 4
    if current_user.has_games?
      delete_game(current_user)
    else
      no_games
    end
  else
    puts "Invalid input"
  end
end
