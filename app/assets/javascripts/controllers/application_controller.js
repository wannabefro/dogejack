App.ApplicationController = Ember.Controller.extend({
  needs: 'login',
  errors: null,
  success: null,
  currentUser: null
});
