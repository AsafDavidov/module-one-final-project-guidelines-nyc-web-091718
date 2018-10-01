class CreateStats < ActiveRecord::Migration[5.0]
  def change
    create_table :stats do |t|
      t.integer :points
      t.integer :rebounds
      t.integer :assists
      t.integer :made_shots
      t.integer :total_shots
      t.integer :field_goal_percentage
    end
  end
end
