App.LoginController = Ember.Controller.extend(Ember.SimpleAuth.LoginControllerMixin, {
  needs: 'application'
});
