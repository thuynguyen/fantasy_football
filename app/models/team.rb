class Team < ActiveRecord::Base
	has_many :games, class_name: "Game", foreign_key: :team_id
	has_many :opponent_games, class_name: "Game", foreign_key: :opponent_team_id
	has_many :user_teams, dependent: :destroy
	has_many :users, through: :user_teams
    
    validates :name, uniqueness: true
	accepts_nested_attributes_for :user_teams
end
