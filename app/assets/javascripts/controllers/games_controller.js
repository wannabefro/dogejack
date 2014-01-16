App.GamesController = Ember.ArrayController.extend({
  itemController: 'game',
  showStatistics: false,
  
  gridSize: function(){
    return 'col-md-' + (12 / this.get('content').length);
  }.property('content.@each'),

  firstGame: function(){
    return this.get('content').get('lastObject');
  }.property('content.@each'),

  totalBet: function(){
    games = this.get('content');
    return games.reduce(function(prev, game){
      return prev + game.get('bet');
    }, 0);
  }.property('content.@each'),

  allSplitHandsPlayed: function(){
    games = this.get('content');
    return (games.length === games.filterBy('state', 'dealers_turn').length);
  }.property('content.@each', '@each.state'),

  actions: {
    statistics: function(){
      this.toggleProperty('showStatistics');
    }
  }
});
