App.GameRoute = Ember.Route.extend(Ember.SimpleAuth.AuthenticatedRouteMixin, {
  model: function() {
    var that = this;
    $.post('/api/games').then(function(response){
      that.store.pushPayload('game', response);
      game = that.store.getById('game', response.games[0].id);
      that.controllerFor('game').set('content', game);
    }, function(err){
      that.controllerFor('application').set('errors', 'Something went wrong. Please try again');
    });
  },

});
