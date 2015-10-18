class Match < ActiveRecord::Base
  has_many :games
  has_one :winning_team, class_name: "Team", foreign_key: :match_id
  
  def winner
    count_time_team_win = self.games.where("games.team_score > games.opponent_team_score").count 
    winner = games.first.team.name if count_time_team_win >= 2
    count_time_opponent_team_win = self.games.where("games.team_score < games.opponent_team_score").count
    winner = games.first.opponent_team.name if count_time_opponent_team_win >= 2
    winner = "Undefined Winner" unless (count_time_team_win >= 2 || count_time_opponent_team_win >= 2) 
    winner
  end
end
