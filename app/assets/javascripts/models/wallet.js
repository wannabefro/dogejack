App.Wallet = DS.Model.extend({
  balance: DS.attr(),
  user: DS.belongsTo('user')
});
