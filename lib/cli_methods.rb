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
