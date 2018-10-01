class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :user_game_id
      t.boolean :indoor?
      t.string :opponent_name
    end
  end
end
