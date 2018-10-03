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
  puts "4 - Delete a game"
  puts "5 - Quit"
end

def add_user_game(user)
  puts "Was your game indoors? (Y/N)"
  indoors = gets.chomp.downcase
  if indoors == "y"
    indoors = true
  else
    indoors = false
  end
  puts "When was the game played (YYYY-MM-DD)?"
  date = gets.chomp
  puts "Who did you play against?"
  opp = gets.chomp
  binding.pry
  game = Game.create({game_date:date,opponent_name:opp,indoor?:indoors})
  UserGame.create({user_id:user.id,game_id:game.id})
  Stat.create(stat_prompt(game))
end

def stat_prompt(game)
  puts "Game Successfully Entered. Please Enter your Stats"
  puts "How many points did you score?"
  input_points = gets.chomp.to_i
  puts "How many shots did you make?"
  input_made_shots = gets.chomp.to_i
  puts "How many shots did you take?"
  input_total_shots = gets.chomp.to_i
  puts "How many assists did you have?"
  input_assists = gets.chomp.to_i
  puts "How many rebounds did you have?"
  input_rebounds = gets.chomp.to_i
  {made_shots:input_made_shots,total_shots:input_total_shots,rebounds:input_rebounds,assists:input_assists,points:input_points,game_id: game.id}
end

def list_games(current_user)
  puts "Here are your games"
  #puts "*" * 30
  current_user.games.each do |game|
    puts "Game Date:#{game.game_date} Opponent: #{game.opponent_name} GameID: #{game.id}"
  end
end

def update_user_stats(current_user)
  list_games(current_user)
  puts "Enter GameID for the game you would like to update."
  input_game_id = gets.chomp.to_i
  stat_to_update = Stat.find_by(game_id: input_game_id)
  game = Game.find(input_game_id)
  stat_to_update.update(stat_prompt(game))
end

def display_stat_menu
  puts "Welcome to your Stats (Which stat would you like to add_user_game)"
  puts "1 - Specific Game Stat"
  puts "2 - Average Stats"
  puts "3 - Lifetime Stats"
  puts "4 - Return to Main Menu"
end

def lifetime_stats(current_user)
  puts "Here are your lifetime stats"
  puts "Points: #{current_user.total_points}"
  puts "Rebounds: #{current_user.total_rebounds}"
  puts "Assists: #{current_user.total_assists}"
  puts "Number of Triple Doubles: #{current_user.num_of_triple_doubles}"
  puts "Field Goal Percentage: #{current_user.total_field_goal_percentage}"
end

def average_stats(current_user)
  puts "Here are your average stats"
  puts "Average Points: #{current_user.avg_points}"
  puts "Average Rebounds: #{current_user.avg_rebounds}"
  puts "Average Assists: #{current_user.avg_assists}"
  puts "Percentage of Triple Doubles: #{current_user.percentage_of_triple_doubles}"
  puts "Field Goal Percentage: #{current_user.total_field_goal_percentage}"
end

def specifc_game_stats(current_user)
  list_games(current_user)
  puts "Enter GameID for that game stat-line."
  input_game_id = gets.chomp.to_i

  if check_gameid_belongs_to_user(current_user,input_game_id)
    stat = Stat.find_by(game_id: input_game_id)
    puts "Here is your stat-line"
    puts "Points: #{stat.points}, Rebounds: #{stat.rebounds}, Assists: #{stat.assists}, Field Goal Percentage: #{stat.field_goal_percent}"
  else
    puts "That's not your game!"
  end
end

def check_gameid_belongs_to_user(user,gameid)
  if UserGame.find_by(user_id: user.id, game_id:gameid) != nil
    true
  else
    false
  end
end

def delete_game(user)
  list_games(user)

  puts "Enter GameID for the game you would like to delete."
  input_game_id = gets.chomp.to_i
  if check_gameid_belongs_to_user(user,input_game_id)
    Game.destroy(input_game_id)
    puts "Your game has been destroyed!"
  else
    puts "That's not one of your games"
  end
end
