App.GameRoute = Ember.Route.extend(Ember.SimpleAuth.AuthenticatedRouteMixin, {
  model: function() {
    var that = this;
    $.post('/api/games').then(function(response){
      game = that.store.createRecord('game', response.game);
      that.controllerFor('game').set('content', game);
    }, function(err){
      that.controllerFor('application').set('errors', 'Something went wrong. Please try again');
    });
  },

});
