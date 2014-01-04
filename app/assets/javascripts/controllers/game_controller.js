App.GameController = Ember.ObjectController.extend({
  actions: {
    start: function(){
      $.post('/api/games').then(function(response){
      }, function(err){
      });
    },

    deal: function(){
      var that = this;
      $.get('/api/games/deal').then(function(response){
        that.store.pushPayload('game', response);
      }, function(err){
      });
    }
  }
});
