require 'spec_helper'

describe Deck do
  it {should belong_to(:game)}
  
  it 'should have 52 cards upon creation' do
    Seeders::Cards.seed
    deck = FactoryGirl.create(:deck)
    expect(deck.cards.count).to eql(52)
  end
end
