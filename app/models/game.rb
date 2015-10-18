class Game < ActiveRecord::Base
  belongs_to :match
  belongs_to :team, class_name: "Team", foreign_key: :team_id
  belongs_to :opponent_team, class_name: "Team", foreign_key: :opponent_team_id
  has_one :user_score
  accepts_nested_attributes_for :team, :opponent_team
  after_create :create_user_score

  #validates :team_id, :opponent_team_id, presence: true

  def winner
    if (team_score.present? && opponent_team_score.present?) 
      (team_score > opponent_team_score) ? self.team.name : self.opponent_team.name
    else
      ""
    end
  end

  def self.histories(current_game_id)
    current_game = self.find_by_id(current_game_id)
    self.where(opponent_team_id: current_game.opponent_team_id, team_id: current_game.team_id).
              where("on_date < ?", Time.zone.now.beginning_of_day).order("on_date DESC")
  end

  def self.listing_games
    games = self.where("on_date >= ?", Time.zone.now.beginning_of_day).order("match_id")
    matches = {}
    games.map do |game|
      matches[game.match_id] = [] if matches[game.match_id].nil?
      matches[game.match_id] << game
    end
    matches
  end

  def create_user_score
    self.team.user_teams.map do |ut|
      ut.user_scores.create(user_team_id: ut.id, game_id: ut.team.games.order("id desc").first.id)
    end
  end
end
