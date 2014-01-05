App.GameController = Ember.ObjectController.extend({
  canDeal: function(){
    if (this.get('state') === 'started'){
      return true;
    }
  }.property('state'),

  canHit: function(){
    if (this.get('state') === 'players_turn'){
      return true;
    }
  }.property('state'),

  finished: function(){
    if (this.get('state') === 'finished'){
      return true;
    }
  }.property('state'),

  dealersTurn: function(){
    var that = this;
    if (this.get('state') === 'dealers_turn'){
      if (!this.dealersPlay){
        this.dealersPlay = setInterval(function(){that.send('getDealersCard')}, 750);
      }
      return true;
    } else if (this.get('state') === 'finished') {
      clearInterval(this.dealersPlay);
      this.dealersPlay = null;
    }
  }.property('state'),

  actions: {
    getDealersCard: function(){
      var that = this;
      $.get('/api/games/dealer').then(function(response){
        that.store.pushPayload('game', response);
      }, function(err){
      });
    },

    deal: function(){
      var that = this;
      $.get('/api/games/deal').then(function(response){
        that.store.pushPayload('game', response);
      }, function(err){
      });
    },

    hit: function(){
      var that = this;
      $.get('/api/games/hit').then(function(response){
        that.store.pushPayload('game', response);
      }, function(err){
      });
    },

    stand: function(){
      var that = this;
      $.get('/api/games/stand').then(function(response){
        that.store.pushPayload('game', response);
      }, function(err){
      });
    },

    again: function(){
      var that = this;
      $.post('/api/games').then(function(response){
        that.store.pushPayload('game', response);
        that.game = that.store.getById('game', response.games[0].id);
        that.set('content', that.game);
        that.send('deal');
      }, function(err){
      });
    }
  }
});
