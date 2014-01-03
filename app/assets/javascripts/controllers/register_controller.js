App.RegisterController = Ember.ObjectController.extend({
  needs: 'application',
  actions: {
    signUp: function(){
      var that = this;
      userInfo = this.getProperties('username', 'email', 'password', 'password_confirmation');
      data = {user: userInfo};
      $.post('/api/registrations', data, null, 'json').then(function(data){
        that.get('controllers.application').send('login');
      }, function(err){
        that.transitionToRoute('register');
      });
    },
    cancel: function() {
      this.transitionToRoute('index');
      return this.get('content').rollback();
    }
  }
});
