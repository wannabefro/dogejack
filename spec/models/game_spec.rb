require 'spec_helper'

describe Game do
  it {should have_many(:decks)}

  it 'should create a new deck on creation' do
    previous_count = Deck.count
    FactoryGirl.create(:game)
    expect(Deck.count).to eql(previous_count + Deck::NUMBER_OF_DECKS)
  end
end
