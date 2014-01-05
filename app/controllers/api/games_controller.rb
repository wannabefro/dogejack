class Api::GamesController < ApplicationController
  before_action :get_user
  before_action :get_game
  before_action :verify_user_token

  def create
    @game ||= Game.create!(user: @user)
    @cards = Card.all
    if @game
      render status: 200, json: [@game]
    else
      render status: 500
    end
  end

  def deal
    @game.deal
    @game.dealt
    render status: 200, json: [@game]
  end

  def hit
    if @game.hit
      render status: 200, json: [@game]
    else
      render status: 500, json: errors
    end
  end

  def stand
    if @game.stand
      render status: 200, json: [@game]
    else
      render status: 500, json: errors
    end
  end

  def dealer
    @game.dealers_turn
    render status: 200, json: [@game]
  end

  private

  def verify_user_token
     @user == current_user
  end

  def get_user
    @user = User.find_by_authentication_token(request.authorization.split(' ')[1])
  end

  def get_game
    @game = @user.unfinished_games.take
  end
end
