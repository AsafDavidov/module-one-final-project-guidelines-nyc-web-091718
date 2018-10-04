class DropIndoorsFromGames < ActiveRecord::Migration[5.0]
  def change
    remove_column :games, :indoor?
  end
end
