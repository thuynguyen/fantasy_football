require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:user1) {create :user}
  let(:user2) {create :user}
  let(:user3) {create :user}
  let(:user4) {create :user}
  let(:team) {create :team, name: "Team A"}
  let(:opponent_team) {create :team, name: "Team B"}
  let(:user_team) {create(:user_team, user_id: user1.id, team_id: team.id)}
  let(:user_team1) {create(:user_team, user_id: user2.id, team_id: opponent_team.id)}
  let(:match) {create :match}
  let(:game) {create(:game, team_id: team.id, opponent_team_id: opponent_team.id, match_id: match.id, team_score: 5, opponent_team_score: 3, on_date: Date.today )}
  let(:game1) {create(:game, team_id: team.id, opponent_team_id: opponent_team.id, team_score: 4, opponent_team_score: 5, on_date: Date.today - 1.day )}
  let(:game2) {create(:game, team_id: team.id, opponent_team_id: opponent_team.id, team_score: nil, opponent_team_score: nil, on_date: Date.today - 2.day  )}
  let(:game3) {create(:game, team_id: team.id, opponent_team_id: opponent_team.id, team_score: 5, opponent_team_score: 5, on_date: Date.today - 3.day  )}

  describe "winner" do
    context "return with team win" do 
      it "team win opponent team" do 
        user_team
        user_team1
        match
        game.winner.should == "Team A"
      end

      it "opponent team win team" do 
        user_team
        user_team1
        match
        game1.winner.should == "Team B"
      end
    end
    context "Undefine winner" do
      it "in case haven't score yet" do 
        user_team
        user_team1
        match
        game2.winner.should == ""
      end
      it "in case the same score with 2 teams" do 
        user_team
        user_team1
        match
        game3.winner.should == ""
      end
    end
  end

  describe "History" do 
    it "return empty history games" do 
      Game.histories(game.id).should == []
    end
    it "return list history games" do 
      current_game = game
      game1
      game2
      game3
      Game.histories(current_game.id).should == [game1, game2, game3]
    end
  end

  describe "Listing games are games on current day" do 
    it "Return listing games" do
      match
      current_game = game
      results = {match.id => [current_game]}
      Game.listing_games.should == results      
    end
  end
end
