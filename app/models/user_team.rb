class UserTeam < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  has_many :user_scores
end
