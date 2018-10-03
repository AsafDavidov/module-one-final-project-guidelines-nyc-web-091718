require 'pry'
class User < ActiveRecord::Base

  has_many :user_games
  has_many :games, through: :user_games
  has_many :stats, through: :games

  def total(category)
    self.games.map do |game|
      game.stats[0][category]
    end.reduce(:+)
  end

  def total_points
    total(:points)
  end

  def total_rebounds
    total(:rebounds)
  end

  def total_assists
    total(:assists)
  end

  def total_field_goal_percentage
     return ((total(:made_shots).to_f/total(:total_shots).to_f)*100).round(1)
  end

  def num_of_triple_doubles
    count = 0
    #binding.pry
    self.games.each do |game|
      #binding.pry
      if game.stats[0][:points] >= 10 && game.stats[0][:rebounds] >= 10 && game.stats[0][:assists] >= 10
          count+=1
      end
    end
    count
  end



end #end of User class
