class GameSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :state, :player_cards, :dealer_cards, :player_score, :dealer_score, :winner
  has_many :decks
  has_one :user
  has_many :cards

  def cards
    object.decks.first.played_cards
  end
end
