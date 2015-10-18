class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_teams, dependent: :destroy
  has_many :teams, through: :user_teams
  validates :first_name, presence: true

  scope :players, -> {where(is_admin: false)}

  def fullname
    [first_name, last_name].join(" ")
  end

  def joined_match
    match_with_team = self.teams.joins(:games).select("distinct games.match_id").where("games.match_id is not null") 
    match_with_opponent_team = self.teams.joins(:opponent_games).select("distinct games.match_id").where("games.match_id is not null")
    match_with_team + match_with_opponent_team
  end

  # Best team player
  def best_combination_of_players
    matches = Match.where(id: self.joined_match.map(&:match_id))
    teams = []
    matches.map do |match|
      teams << match.winner
    end
    best_teams = teams.uniq.max_by{ |team| teams.count( team ) }
    best_teams
  end

  private
  def email_required?
    false
  end 
  def password_required?
    !new_record? ? super : false
  end  
end
