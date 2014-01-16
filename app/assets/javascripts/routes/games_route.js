App.GamesRoute = Ember.Route.extend(Ember.SimpleAuth.AuthenticatedRouteMixin, {
  model: function() {
    var that = this;
    $.post('/api/games').then(function(response){
      that.store.pushPayload('game', response);
      if (response.games[0].split == true){
        games = that.store.filter('game').filterBy('split').filterBy('winner', null);
      } else {
      games = that.store.getById('game', response.games[0].id);
      }
      that.controllerFor('games').set('content', [games]);
    }, function(err){
      that.controllerFor('application').set('errors', 'Something went wrong. Please try again');
    });
  }

});
