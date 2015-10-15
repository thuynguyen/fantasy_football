class CreateUserScores < ActiveRecord::Migration
  def change
    create_table :user_scores do |t|
      t.integer :score
      t.references :user_team, index: true, foreign_key: true
      t.datetime :on_date

      t.timestamps null: false
    end
  end
end
