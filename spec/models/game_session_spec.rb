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

    context 'dealing to split hands' do
      before(:each) do
        @game_session = game.game_session
        game.deal
        game.player_cards = @nines.pop(2)
        @game_session.split(game)
      end

      it 'should not deal unless all split hands have been played' do
        game_one = @game_session.games.first
        game_one.stand
        expect(@game_session.split_deal(@game_session.games)).to be_false
      end

      it 'should deal if all split hands have been played' do
        game_one = @game_session.games.first
        game_two = @game_session.games.last
        game_one.stand
        game_two.stand
        expect(@game_session.split_deal(@game_session.games)).to be_true
      end
    end

    it 'should deal the same dealer cards to each split hand' do
      game_session = game.game_session
      game.deal
      game.player_cards = @nines.pop(2)
      game_session.split(game)
      games = game_session.games
      game_session.split_deal(games)
      expect(games.last.dealer_cards).to eql(games.first.dealer_cards)
    end
  end
end
