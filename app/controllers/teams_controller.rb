class TeamsController < ApplicationController
  def show
    @users = Team.find_by_id(params[:id]).users
  end
end
