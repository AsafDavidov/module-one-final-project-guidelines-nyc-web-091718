class DropUserGameIdFromGames < ActiveRecord::Migration[5.0]
  def change
    remove_column :games, :user_game_id
  end
end
