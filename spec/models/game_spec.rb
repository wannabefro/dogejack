require 'spec_helper'

describe Game do
  it {should belong_to(:user)}
  it {should belong_to(:game_session)}

  let(:game) {FactoryGirl.create(:game)}
  let(:seed) {Seeders::Cards.seed}

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

  context 'get winner' do
    it 'the dealer wins if the player busts' do
      game.stub(:player_score) {22}
      game.get_winner
      expect(game.winner).to eql('dealer')
    end

    it 'the player wins if the dealer busts' do
      game.stub(:dealer_score) {22}
      game.get_winner
      expect(game.winner).to eql('player')
    end

    it 'the player wins if they have a higher score than the dealer' do
      game.stub(:player_score) {21}
      game.stub(:dealer_score) {17}
      game.get_winner
      expect(game.winner).to eql('player')
    end

    it 'the dealer wins if they have a higher score than the player' do
      game.stub(:player_score) {17}
      game.stub(:dealer_score) {21}
      game.get_winner
      expect(game.winner).to eql('dealer')
    end

    it 'should be a tie if they both have the same score' do
      game.stub(:player_score) {21}
      game.stub(:dealer_score) {21}
      game.get_winner
      expect(game.winner).to eql('tie')
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

  context 'splitting' do
    before(:each) do
      seed
      @kings = Card.all.keep_if {|x| x.value == 'K'}.map{|x| x.id}
      game.player_cards = @kings[0..1]
    end

    it 'should allow you to split if you have 2 cards of the same value' do
      game.dealt
      game.split
      expect(game.player_cards.length).to eql(2)
      expect(game.split_cards[0].length).to eql(2)
      expect(game.split_bets[0]).to eql(game.bet)
    end

    it 'should calculate a split hands value' do
      game.dealt
      game.split
      game.split_cards[0] = @kings.pop(2)
      expect(game.split_score(0)).to eql(20)
    end
  end
end
