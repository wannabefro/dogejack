App.Game = DS.Model.extend({
  user: DS.belongsTo('user'),
  decks: DS.hasMany('deck'),
  dealerCards: DS.attr('raw'),
  playerCards: DS.attr('raw'),
  state: DS.attr()
});
