class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    listing_games
  end

  # GET /games/1
  # GET /games/1.json
  # def show
  # end

  # GET /games/new
  def new
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

  private
    def listing_games
      @games = Game.all.order("created_at DESC")
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