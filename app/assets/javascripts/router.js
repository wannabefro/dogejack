// For more information see: http://emberjs.com/guides/routing/

App.Router.map(function() {
  this.route('login');
  this.route('home', {path: '/'});
  this.route('register', {path: '/sign-up'});
});
