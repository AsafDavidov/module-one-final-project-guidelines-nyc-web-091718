require_relative '../config/environment'

def welcome
  puts "\u{1F3C0}" * 23
  puts "\u{1F3C0}       Welcome to ATTAC StatTracker" + "       \u{1F3C0}"
  puts "\u{1F3C0}" * 23
  sleep(0.2)
  puts "Are you a new user? (Y/N)"
end

def wrong_login_prompt
  puts "Username not found: Please try again (cap sensitive)"
  sleep(0.2)
  puts "Would you like to create a new user? (Y/N) or Quit (Q)"
end

def create_new_user
  puts "Please provide the following information"
  sleep(0.2)
  puts "First Name"
  new_user_first_name = gets.chomp
  sleep(0.2)
  puts "Last Name"
  new_user_last_name = gets.chomp
  sleep(0.2)
  puts "Username (Must be unique!)"
  new_user_username = gets.chomp
  if check_for_unique_username(new_user_username) != nil
    puts "Username has been taken! Be more unique!"
    puts ""
    sleep(0.2)
    nil
  else
    User.create({first_name:new_user_first_name, last_name:new_user_last_name, username: new_user_username})
  end

end

def check_for_unique_username(username)
  User.all.find_by(username: username)
end

def look_for_user
  sleep(0.2)
  puts "Enter your username"
  username = gets.chomp
  User.all.find_by({username: username})
end

def basketballs
  puts "\u{1F3C0}" * 23
  puts "\u{1F3C0}" * 23
end

def display_menu(user)
  sleep(0.2)
  basketballs
  puts "Welcome #{user.username}"
  sleep(0.2)
  puts "Display Menu (Choose your option)"
  puts "1 - Add Game"
  puts "2 - Update Previous Game Stats"
  puts "3 - Explore Stats"
  puts "4 - Delete a game"
  puts "5 - Quit"
end

def add_user_game(user)
  puts "When was the game played (YYYY-MM-DD)?"
  date = gets.chomp
  y, m, d = date.split("-")
  if Date.valid_date?(y.to_i, m.to_i, d.to_i)
    sleep(0.2)
    puts "Who did you play against?"
    opp = gets.chomp
    game = Game.new({game_date:date,opponent_name:opp})
    stats = stat_prompt
    if stats == {}
      sleep(0.2)
      puts "Invalid Stat input"
    else
      game.save
      UserGame.create({user_id:user.id,game_id:game.id})
      stats[:game_id] = game.id
      Stat.create(stats)
      puts "Game Successfully Entered."
    end
  else
    puts "Invalid date entry!"
  end
end

def stat_prompt
  sleep(0.2)
  puts "Please Enter Your Stats".underline
  sleep(0.2)
  puts "How many points did you score?"
  input_points = gets.chomp.to_i
  sleep(0.2)
  puts "How many shots did you make?"
  input_made_shots = gets.chomp.to_i
  sleep(0.2)
  puts "How many shots did you take?"
  input_total_shots = gets.chomp.to_i
    if input_made_shots > input_total_shots
      sleep(0.2)
      puts "You can't make more shots than you take!"
      empty_hash = {}
      #return empty_hash
    else
      sleep(0.2)
      puts "How many assists did you have?"
      input_assists = gets.chomp.to_i
      sleep(0.2)
      puts "How many rebounds did you have?"
      input_rebounds = gets.chomp.to_i
      {made_shots:input_made_shots,total_shots:input_total_shots,rebounds:input_rebounds,assists:input_assists,points:input_points}
    end
end

def list_games(current_user)
  sleep(0.2)
    puts "Here are your games"
    sleep(0.2)
    current_user.games.each do |game|
      puts "Game Date:#{game.game_date} | Opponent: #{game.opponent_name} | GameID: #{game.id}"
    end
end

def no_games
  sleep(0.2)
  puts "You have no games yet. Please add game"
end

def update_user_stats(current_user)
  list_games(current_user)
  puts "Enter GameID for the game you would like to update."
  input_game_id = gets.chomp.to_i
  if check_gameid_belongs_to_user(current_user,input_game_id)
    stat_to_update = Stat.find_by(game_id: input_game_id)
    stats = stat_prompt
    if stats == {}
      puts "Invalid Stat input"
    else
      stats[:game_id] = input_game_id
      stat_to_update.update(stats)
      puts "Successfully updated your stat-line!"
    end
  else
    puts "That's not one of your games"
  end
end

def display_stat_menu
  sleep(0.2)
  basketballs
  puts "Welcome to your Stats (Which stat would you like to access)"
  sleep(0.2)
  puts "1 - Specific Game Stat"
  puts "2 - Average Stats"
  puts "3 - Lifetime Stats"
  puts "4 - Return to Main Menu"
end

def lifetime_stats(current_user)
  puts "Here are your lifetime stats:".underline
  puts "Points: #{current_user.total_points}"
  puts "Rebounds: #{current_user.total_rebounds}"
  puts "Assists: #{current_user.total_assists}"
  puts "Number of Triple Doubles: #{current_user.num_of_triple_doubles}"
  puts "Field Goal Percentage: #{current_user.total_field_goal_percentage}"
  puts ""
end

def average_stats(current_user)
  puts "Here are your average stats:".underline
  puts "Average Points: #{current_user.avg_points}"
  puts "Average Rebounds: #{current_user.avg_rebounds}"
  puts "Average Assists: #{current_user.avg_assists}"
  puts "Percentage of Triple Doubles: #{current_user.percentage_of_triple_doubles}"
  puts "Field Goal Percentage: #{current_user.total_field_goal_percentage}"
  puts ""
end

def specifc_game_stats(current_user)
  list_games(current_user)
  puts "Enter GameID for that game stat-line."
  input_game_id = gets.chomp.to_i
  if check_gameid_belongs_to_user(current_user,input_game_id)
    stat = Stat.find_by(game_id: input_game_id)
    puts "Here is your stat-line:".underline
    puts "Points: #{stat.points}, Rebounds: #{stat.rebounds}, Assists: #{stat.assists}, Field Goal Percentage: #{stat.field_goal_percent}"
  else
    puts "That's not your game!"
  end
  puts ""
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
