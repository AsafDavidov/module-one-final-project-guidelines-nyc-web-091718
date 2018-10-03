class Stat < ActiveRecord::Base

  belongs_to :game
  def field_goal_percent
    ((self.made_shots.to_f/self.total_shots.to_f)*100).round(1)
  end

end
