App.User = DS.Model.extend({
  username: DS.attr(),
  games: DS.hasMany('game'),
  wallets: DS.hasMany('wallet'),
  won: DS.attr(),
  lost: DS.attr(),
  tied: DS.attr()
});
