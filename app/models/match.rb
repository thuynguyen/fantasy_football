class Match < ActiveRecord::Base
	has_many :games
	has_one :team
end
