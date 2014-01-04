App.Deck = DS.Model.extend({
  game: DS.belongsTo('game'),
  cards: DS.hasMany('card')
});
