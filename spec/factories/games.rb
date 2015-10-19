FactoryGirl.define do
  factory :game do
    team
    opponent_team
    match
    team_score 1
    opponent_team_score 1
  end

end
