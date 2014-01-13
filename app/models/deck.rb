class Deck < ActiveRecord::Base
  belongs_to :game_session
  before_create :build_deck

  has_many :deck_cards, dependent: :destroy
  has_many :cards, through: :deck_cards

  def unplayed_cards
    cards.references(:deck_cards).where(deck_cards: {played: false})
  end

  def played_cards
    cards.references(:deck_cards).where(deck_cards: {played: true})
  end

  private
  def build_deck
    Card.all.each do |card|
      self.cards << card
    end
  end
end
