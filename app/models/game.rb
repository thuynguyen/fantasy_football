class Game < ActiveRecord::Base
  belongs_to :match
  belongs_to :team, class_name: "Team", foreign_key: :team_id
  belongs_to :opponent_team, class_name: "Team", foreign_key: :opponent_team_id
  accepts_nested_attributes_for :team, :opponent_team

  def winner
  	(team_score.present? && opponent_team_score.present?) && (team_score > opponent_team_score) ? self.team.name : self.opponent_team.name
  end
end
