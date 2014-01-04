App.Game = DS.Model.extend({
  user: DS.belongsTo('user'),
  decks: DS.hasMany('deck'),
  dealerCards: DS.attr(),
  playerCards: DS.attr(),
  state: DS.attr(),

  playerHand: function(){
    return this.get('playerCards');
  }.property('@each.playerCards')
});
