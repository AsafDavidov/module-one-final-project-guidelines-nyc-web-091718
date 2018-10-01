class AddGamesToStats < ActiveRecord::Migration[5.0]
  def change
    add_column :stats, :game_id, :integer
  end
end
