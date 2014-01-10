class GameSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :state, :player_cards, :dealer_cards, :player_score, :dealer_score, :winner, :bet, :shoe_penetration
  has_one :user
  has_many :cards

  def cards
    object.game_session.decks.map { |deck| deck.played_cards }.flatten
  end
end
