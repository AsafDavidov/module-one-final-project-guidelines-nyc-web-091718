require_relative '../config/environment'

user = User.create({first_name:"Lebron",last_name:"James",number:23,username:"LBJames23"})

CSV.foreach("csv/lebron_stats.csv") do |row|
  game = Game.create({game_date:row[0],opponent_name:row[1],indoor?:true})
  UserGame.create({user_id:user.id,game_id:game.id})
end


binding.pry

#first upload game
#create user_game instance related to current player and current game
#for current game, upload stats
#
#Date,Opp,FG,FGA,TRB,AST,PTS
# 2017-10-20,MIL,10,16,5,8,24
# 2017-10-21,ORL,8,15,4,2,22
# 2017-10-24,CHI,13,20,2,13,3
