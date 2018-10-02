class AddDateToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :game_date, :date
  end
end
