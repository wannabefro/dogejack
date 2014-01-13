App.GameController = Ember.ObjectController.extend({
  needs: ['application'],
  errors: null,
  betAmount: null,
  doubling: false,

  canSplit: function(){
    if (this.get('playerCards') != undefined && this.get('playerCards').length === 2 && this.get('sameValue')){
      return true;
    }
  }.property('playerCards'),

  sameValue: function(){
    cardValues = [];
    this.get('playerHand').forEach(function(card){cardValues.push(card.get('value'))})
    if (cardValues[0] == cardValues[1]){
      return true;
    }
  }.property('playerCards'),

  canBet: function(){
    var balance = this.get('controllers.application.currentUser').get('wallets').get('content')[0].get('balance');
    if (balance > 0){
      return true;
    }
  }.property('state'),

  validBet: function(){
    var balance = this.get('controllers.application.currentUser').get('wallets').get('content')[0].get('balance');
    if (parseInt(this.get('betAmount'), 10) <= balance){
      this.get('controllers.application').set('errors', null);
      return true;
    }
  }.property(),

  checkDouble: function(){
    var balance = this.get('controllers.application.currentUser').get('wallets').get('content')[0].get('balance');
    var doubleBet = parseInt(this.get('doubleBet'));
    if (doubleBet <= balance && doubleBet <= this.get('bet')){
      return true;
    }
  }.property('doubleBet'),

  canDouble: function(){
    if (this.get('playerCards') != undefined && this.get('playerCards').length === 2 && this.get('playerScore') != 21){
      return true;
    }
  }.property('playerCards'),

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
        this.dealersPlay = setInterval(function(){that.send('getDealersCard');}, 750);
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
      if (this.get('bet') !== 0){
        this.set('betAmount', this.get('bet'));
      }
      data = this.getProperties('betAmount');
      if (this.get('validBet')){
        $.get('/api/games/deal', data).then(function(response){
          that.store.pushPayload('game', response);
        }, function(err){
          that.set('errors', err.errors);
        });
      } else {
        this.get('controllers.application').set('errors', 'That wasn\'t a valid bet');
      }
      this.set('betAmount', null);
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
      this.set('betAmount', this.get('bet'));
      $.post('/api/games').then(function(response){
        that.store.pushPayload('game', response);
        that.game = that.store.getById('game', response.games[0].id);
        that.set('content', that.game);
        that.send('deal');
      }, function(err){
      });
    },

    split: function(){
      var that = this;
      $.get('/api/games/split').then(function(response){
      }, function(err){
      });
    },

    double: function(){
      if (this.get('checkDouble')){
        this.set('controllers.application.errors', null);
        data = this.getProperties('doubleBet');
        var that = this;
        $.get('/api/games/double', data).then(function(response){
          that.store.pushPayload('game', response);
          that.set('bet', response.games[0].bet);
          that.toggleProperty('doubling');
        }, function(err){
        })
      } else {
          this.set('controllers.application.errors', 'You can\'t double more than ' + this.get('bet'));
        }
      },

    willDouble: function(){
      if (this.get('doubleBet') != undefined){
        this.send('double');
      } else {
        this.toggleProperty('doubling');
      }
    }
  }
});
