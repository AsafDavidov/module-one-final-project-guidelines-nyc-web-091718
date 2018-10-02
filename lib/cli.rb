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
