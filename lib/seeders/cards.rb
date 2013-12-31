module Seeders
  module Cards
    class << self
      def seed
        SUITS.each do |suit|
          VALUES.each do |value|
            Card.find_or_create_by(suit: suit, value: value)
          end
        end
      end

      SUITS  = ['♠', '♣', '♥', '♦']
      VALUES = ( '2'..'10' ).to_a.concat( ['J', 'Q', 'K', 'A'] )
    end
  end
end
