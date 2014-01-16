class GameSession < ActiveRecord::Base
  has_many :games, dependent: :destroy
  has_many :decks, dependent: :destroy
  has_many :cards, through: :decks
  belongs_to :user

  after_create :create_decks

  NUMBER_OF_DECKS = 6

  def number_of_decks
    NUMBER_OF_DECKS
  end

  def create_decks
    NUMBER_OF_DECKS.times do
      Deck.create!(game_session_id: id)
    end
  end

  def play_card
    card = decks.map { |deck| deck.deck_cards.where(played: false) }.flatten.sample
    card.played = true
    card.save!
    card.card
  end

  def split(game)
    if game.can_split?(game.player_cards)
      game.player_cards_will_change!
      split_card = game.player_cards.pop
      game.update_attributes(player_cards: game.player_cards, split: true)
      split_game = Game.create(game_session_id: id, user_id: game.user.id, bet: game.bet, dealer_cards: game.dealer_cards, player_cards:  [split_card], split: true)
      game.dealt
      split_game.dealt
      game.hit
      split_game.hit
    else
      false
    end
  end

  def split_deal(games)
    if games.all?{|game|game.state == 'dealers_turn'}
      first_game = Game.first
      first_game.deal
      games.each do |game|
        game.dealer_cards_will_change!
        game.update_attributes(dealer_cards: first_game.dealer_cards)
        if first_game.state == 'finished' && game.state != 'finished'
          game.finish
        end
      end
      games
    else
      false
    end
  end

  def played_cards
    cards.references(:deck_cards).where(deck_cards: {played: true}).pluck(:value)
  end

  def penetration_level
    played_cards = 0
    decks.each do |deck|
      played_cards += deck.played_cards.count
    end
    1 - (played_cards / (decks.count * Card.count.to_f))
  end

end
