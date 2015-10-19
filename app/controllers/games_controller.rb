class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy, :history, :join_match, :users_team]

  # GET /games
  # GET /games.json
  def index
    listing_games
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @user_teams = @game.team.user_teams
  end

  # GET /games/new
  def new
    @teams = Team.order("name ASC")
    @users = User.players.order("first_name").map{|user| [user.first_name, user.id]}
    @game = Game.new
    @team = @game.build_team
    @opponent_team = @game.build_opponent_team
    @team.user_teams.build
    @opponent_team.user_teams.build
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    if params[:old_list_team] == "true"
      @game = Game.new(game_old_params)
    else
      @game = Game.new(game_params)
    end

    respond_to do |format|
      @game.save
      listing_games
      format.js 
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      @game.update(game_old_params)
      listing_games
      format.js
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    listing_games
    # respond_to do |format|
    #   format.js { render :index }
    # end
    redirect_to games_path
  end

  def history
    @games = Game.histories(@game.id)
  end

  def stats 
    @users = User.players.order("first_name, last_name")
  end
  
  # Create maximum 3 games in a match
  def join_match
    match = Match.create()
    @game.update_attributes(match_id: match.id)
    2.times do |time|
      game = Game.new 
      game.attributes = @game.attributes.except("id", "team_score", "opponent_team_score")
      game.save
    end
    listing_games
  end

  private
    def listing_games
      @games = Game.listing_games

    end
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    def game_old_params
      params.require(:game).permit(:on_date, :team_id, :opponent_team_id, :match_id, :team_score, 
                                   :opponent_team_score)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:on_date, :match_id, :team_score, 
                                   :opponent_team_score, team_attributes: [:name, user_teams_attributes: [:user_id, :team_id]], 
                                   opponent_team_attributes: [:name, user_teams_attributes: [:user_id, :team_id]])
    end
end