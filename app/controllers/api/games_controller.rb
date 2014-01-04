class Api::GamesController < ApplicationController
  before_action :get_user
  before_action :verify_user_token

  def create
    close_games
    @game = Game.create!(user: @user)
    if @game
      render status: 200, json: @game
    else
      render status: 500
    end
  end

  def deal
    @game = @user.unfinished_games.take
    @game.get_card
    render status: 200, json: @game
  end

  private

  def verify_user_token
     @user == current_user
  end

  def get_user
    @user = User.find_by_authentication_token(request.authorization.split(' ')[1])
  end

  def close_games
    @user.unfinished_games.each {|x| x.finish}
  end

end
