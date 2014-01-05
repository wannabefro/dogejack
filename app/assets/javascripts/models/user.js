App.User = DS.Model.extend({
  username: DS.attr(),
  games: DS.hasMany('game'),
  won: DS.attr(),
  lost: DS.attr(),
  tied: DS.attr()
});
