class Game < ActiveRecord::Base
  belongs_to :user
  has_many :decks, dependent: :destroy
  has_many :cards, through: :decks
  after_create :create_decks
  NUMBER_OF_DECKS = 1

  state_machine :state, initial: :started do 
    event :finish do
      transition all => :finished
    end
  end

  def get_card
    player_cards_will_change!
    deck = decks.take
    card = deck.unplayed_cards.sample
    deck.play_card(card)
    update_attributes(player_cards: player_cards.push(card.id))
  end

  private
  def create_decks
    NUMBER_OF_DECKS.times do
      Deck.create!(game_id: id)
    end
  end
  
end
