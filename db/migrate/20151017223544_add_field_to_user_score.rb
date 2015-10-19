class AddFieldToUserScore < ActiveRecord::Migration
  def change
    add_reference :user_scores, :game, index: true, foreign_key: true
  end
end
