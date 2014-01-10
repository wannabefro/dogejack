class GameSession < ActiveRecord::Base
  has_many :games 
  has_many :decks
  belongs_to :user

  after_create :create_decks

  NUMBER_OF_DECKS = 6

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

end
