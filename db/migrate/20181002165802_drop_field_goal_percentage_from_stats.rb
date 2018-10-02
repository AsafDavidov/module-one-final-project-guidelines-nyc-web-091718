class DropFieldGoalPercentageFromStats < ActiveRecord::Migration[5.0]
  def change
    remove_column :stats, :field_goal_percentage
  end
end
