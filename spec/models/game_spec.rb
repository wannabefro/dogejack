require 'spec_helper'

describe Game do
  it {should have_many(:decks)}
  it {should have_many(:cards)}
  it {should belong_to(:user)}

  let(:game) {FactoryGirl.create(:game)}
  let(:seed) {Seeders::Cards.seed}

  it 'should create a new deck on creation' do
    previous_count = Deck.count
    FactoryGirl.create(:game)
    expect(Deck.count).to eql(previous_count + Game::NUMBER_OF_DECKS)
  end

  it 'should deal cards' do
    seed
    game.deal
    expect(game.player_cards.count).to eql(2)
    expect(game.dealer_cards.count).to eql(1)
  end

  it 'should have initial state of started' do
    expect(game.state).to eql('started')
  end

  context 'aces' do
    before(:each) do
      seed
      aces = Card.all.keep_if {|x| x.value == 'A'}.map{|x| x.id}
      nines = Card.all.keep_if {|x| x.value == '9'}.map{|x| x.id}
      game.player_cards = [aces[0], nines[0]]
    end

    it 'will change the value of the ace if your going to bust' do
      expect(game.player_score).to eql(20)
      game.dealt
      game.hit
      expect(game.state).to_not eql('finished')
    end
  end

  context 'scores' do
    before(:each) do
      seed
      kings = Card.all.keep_if {|x| x.value == 'K'}.map{|x| x.id}
      game.player_cards = kings[0..1]
      game.dealer_cards = kings[2..-1]
    end
    
    it 'should calculate the players score' do
      expect(game.player_score).to eql(20)
    end

    it 'should calculate the dealers score' do
      expect(game.dealer_score).to eql(20)
    end
  end

  context 'hitting' do
    it 'should get a card if not bust' do
      seed
      game.dealt
      game.hit
      expect(game.player_cards.count).to eql(1)
    end

    it 'should finish the game if you go bust' do
      seed
      game.dealt
      game.stub(:player_score) {22}
      game.hit
      expect(game.state).to eql('finished')
    end
  end
end
