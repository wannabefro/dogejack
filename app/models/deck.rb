class Deck < ActiveRecord::Base
  belongs_to :game
  before_create :build_deck

  has_many :deck_cards, dependent: :destroy
  has_many :cards, through: :deck_cards


  private
  def build_deck
    Card.all.each do |card|
      self.cards << card
    end
  end
end
