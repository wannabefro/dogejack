require 'spec_helper'

describe GameSession do
  it {should belong_to(:user)}
  it {should have_many(:cards)}
  it {should have_many(:games)}
  it {should have_many(:decks)}

  let(:game) {FactoryGirl.create(:game)}
  let(:seed) {Seeders::Cards.seed}

  context 'splitting' do
    before(:each) do
      seed
      @nines = Card.all.keep_if {|x| x.value == '9'}.map{|x| x.id}
    end

    it 'should create a new game upon splitting' do
      game_session = game.game_session
      game.deal
      game.player_cards = @nines.pop(2)
      game_session.split(game)
      expect(Game.count).to eql(2)
      expect(Game.first.player_cards.length).to eql(2)
      expect(Game.last.player_cards.length).to eql(2)
    end

    it 'should not become the dealers turn until all split hands are played' do
      game_session = game.game_session
      game.deal
      game.player_cards = @nines.pop(2)
      game_session.split(game)
      Game.first.stand
    end
  end
end
