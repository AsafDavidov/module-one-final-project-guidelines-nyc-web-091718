require_relative '../config/environment'

user1 = User.create({first_name:"Lebron",last_name:"James",username:"LBJames23"})
user2 = User.create({first_name:"Steph",last_name:"Curry",username:"StephCurry30"})
user3 = User.create({first_name:"James",last_name:"Harden",username:"JamesHard"})
user4 = User.create({first_name:"Russell",last_name:"Westbrook",username:"Cupcakes"})
user5 = User.create({first_name:"JJ",last_name:"Redick",username:"DeepBall"})

CSV.foreach("csv/lebron_stats.csv") do |row|
  game = Game.create({game_date:row[0],opponent_name:row[1],indoor?:true})
  UserGame.create({user_id:user1.id,game_id:game.id})
  Stat.create({made_shots:row[2],total_shots:row[3],rebounds:row[4],assists:row[5],points:row[6],game_id: game.id})
end

CSV.foreach("csv/step_curry.csv") do |row|
  game = Game.create({game_date:row[0],opponent_name:row[1],indoor?:true})
  UserGame.create({user_id:user2.id,game_id:game.id})
  Stat.create({made_shots:row[2],total_shots:row[3],rebounds:row[4],assists:row[5],points:row[6],game_id: game.id})
end

CSV.foreach("csv/james_harden.csv") do |row|
  game = Game.create({game_date:row[0],opponent_name:row[1],indoor?:true})
  UserGame.create({user_id:user3.id,game_id:game.id})
  Stat.create({made_shots:row[2],total_shots:row[3],rebounds:row[4],assists:row[5],points:row[6],game_id: game.id})
end

CSV.foreach("csv/rus_wb.csv") do |row|
  game = Game.create({game_date:row[0],opponent_name:row[1],indoor?:true})
  UserGame.create({user_id:user4.id,game_id:game.id})
  Stat.create({made_shots:row[2],total_shots:row[3],rebounds:row[4],assists:row[5],points:row[6],game_id: game.id})
end

CSV.foreach("csv/jj_redick.csv") do |row|
  game = Game.create({game_date:row[0],opponent_name:row[1],indoor?:true})
  UserGame.create({user_id:user5.id,game_id:game.id})
  Stat.create({made_shots:row[2],total_shots:row[3],rebounds:row[4],assists:row[5],points:row[6],game_id: game.id})
end

#binding.pry

#first upload game
#create user_game instance related to current player and current game
#for current game, upload stats
#
#Date,Opp,FG,FGA,TRB,AST,PTS
