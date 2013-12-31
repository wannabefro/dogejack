class Game < ActiveRecord::Base
  belongs_to :user
  has_many :decks, dependent: :destroy
  after_create :create_decks
  NUMBER_OF_DECKS = 1

  private
  def create_decks
    NUMBER_OF_DECKS.times do
      Deck.create!(game_id: id)
    end
  end
  
end
