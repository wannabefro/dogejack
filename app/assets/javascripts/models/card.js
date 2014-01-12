App.Card = DS.Model.extend({
  value: DS.attr(),
  suit: DS.attr(),
  decks: DS.hasMany('deck'),

  path: function() {
    return "/assets/cards/" + this.get('cardString') +  ".svg"
  }.property(),

  cardString: function() {
    return this.get('value') + this.get('suitLetter');
  }.property(),

  suitLetter: function() {
    return {"♦": "D", "♠": "S", "♥": "H", "♣": "C"}[this.get('suit')];
  }.property()
});
