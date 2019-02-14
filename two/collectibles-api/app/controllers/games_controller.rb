class GamesController < ApplicationController
  before_action :set_game, only: [:show, :update, :destroy]

  # GET /games
  def index
    @games = current_user.games
    json_response @games
  end

  # POST /games
  def create
    @game = current_user.games.create! game_params
    json_response(@game, :created)
  end

  def show
    json_response @game
  end

  def update
    @game.update game_params
    head :no_content
  end

  def destroy
    @game.destroy
    head :no_content
  end

  private

  def game_params
    # whitelist
    params.permit(:title, :pg, :rating)
  end

  def set_game
    @game = current_user.games.find(params[:id])
  end
end
