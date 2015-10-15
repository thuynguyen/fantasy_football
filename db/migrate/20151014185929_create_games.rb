class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :team_id
      t.integer :opponent_team_id
      t.references :match, index: true, foreign_key: true
      t.integer :team_score
      t.integer :opponent_team_score
      t.datetime :on_date

      t.timestamps null: false
    end
    add_index :games, :team_id
    add_index :games, :opponent_team_id
  end
end
