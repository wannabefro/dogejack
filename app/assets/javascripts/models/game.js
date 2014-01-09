App.Game = DS.Model.extend({
  user: DS.belongsTo('user'),
  decks: DS.hasMany('deck'),
  dealerCards: DS.attr('raw'),
  playerCards: DS.attr('raw'),
  state: DS.attr(),
  playerScore: DS.attr(),
  dealerScore: DS.attr(),
  winner: DS.attr(),
  bet: DS.attr(),
  split: DS.attr(),
  splitCards: DS.attr('raw'),
  splitBets: DS.attr('raw'),

  playerHand: function(){
    var that = this;
    return this.get('playerCards').map(function(item){
      return that.store.getById('card', item);
    });
  }.property('playerCards'),

  dealerHand: function(){
    var that = this;
    return this.get('dealerCards').map(function(item){
      return that.store.getById('card', item);
    });
  }.property('dealerCards')

});
