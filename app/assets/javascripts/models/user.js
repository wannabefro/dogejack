App.User = DS.Model.extend({
  username: DS.attr(),
  games: DS.hasMany('game')
});
