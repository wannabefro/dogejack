class Game < ActiveRecord::Base
  belongs_to :user
  has_many :decks, dependent: :destroy
  after_create :create_decks
  NUMBER_OF_DECKS = 1

  state_machine :state, initial: :started do 
    event :finish do
      transition all => :finished
    end
  end

  private
  def create_decks
    NUMBER_OF_DECKS.times do
      Deck.create!(game_id: id)
    end
  end
  
end
