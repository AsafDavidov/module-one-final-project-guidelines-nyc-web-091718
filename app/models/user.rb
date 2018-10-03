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



end
