class Game < ActiveRecord::Base
  belongs_to :match
  belongs_to :team, class_name: "Team", foreign_key: :team_id
  belongs_to :opponent_team, class_name: "Team", foreign_key: :opponent_team_id

end
