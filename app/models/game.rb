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
    deck = decks.take
    card = deck.cards.pop
    deck.cards.delete(card)
    player_cards << card
    self.save!
  end

  private
  def create_decks
    NUMBER_OF_DECKS.times do
      Deck.create!(game_id: id)
    end
  end
  
end
