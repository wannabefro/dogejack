App.GamesController = Ember.ArrayController.extend({
  itemController: 'game',
  showStatistics: false,
  
  gridSize: function(){
    return 'col-md-' + (12 / this.get('content').length);
  }.property('content'),

  firstGame: function(){
    return this.get('content')[0];
  }.property('content'),

  totalBet: function(){
    games = this.get('content');
    return games.reduce(function(prev, game){
      return prev + game.get('bet');
    }, 0);
  }.property('content', '@each.bet'),

  actions: {
    statistics: function(){
      this.toggleProperty('showStatistics');
    }
  }
});
