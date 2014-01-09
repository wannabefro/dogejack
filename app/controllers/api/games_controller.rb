class Api::GamesController < ApplicationController
  before_action :get_user
  before_action :get_game
  before_action :verify_user_token
  before_action :get_wallet, only: [:deal]

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
    @game.bet = params[:betAmount].to_i if params[:betAmount]
    @game.dealt
    @wallet.update_attributes(balance: (@wallet.balance -= @game.bet))
    render status: 200, json: [@game]
  end

  def split
    if @game.split
      render status: 200, json: [@game]
    else
      render status: 500, json: {errors: 'Sorry something went wrong with the split'}
    end
  end

  def double
    if @game.double(params[:doubleBet].to_i)
      render status: 200, json: [@game]
    else
      render status: 500, json: {errors: 'Sorry something went wrong'}
    end
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

  def get_wallet
    if @user
      @wallet = @user.wallets.take
    end
  end
end
