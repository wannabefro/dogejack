App.RegisterController = Ember.ObjectController.extend({
  needs: ['login', 'application'],
  errors: null,
  actions: {
    signUp: function(){
      var _this = this;
      userInfo = this.getProperties('username', 'email', 'password', 'password_confirmation');
      data = {user: userInfo};
      $.post('/api/registrations', data, null, 'json').then(function(response){
        Ember.run(function() {
          response.user[0].users = [response.user[0].users];
          _this.get('session').setup(response);
          _this.send('loginSucceeded');
          _this.store.pushPayload('user', response.user[0]);
          _this.get('controllers.application').set('currentUser', _this.store.getById('user', response.user[0].users[0].id));
        });
        _this.get('controllers.application').set('success', 'Welcome to DogeJack ' + response.user.username);
      }, function(err){
        _this.set('errors', err.responseJSON.errors);
        _this.transitionToRoute('register');
      });
    },
    cancel: function() {
      this.transitionToRoute('index');
      return this.get('content').rollback();
    }
  }
});
