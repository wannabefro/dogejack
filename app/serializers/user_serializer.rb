class UserSerializer < ActiveModel::Serializer
  self.root 'users'
  embed :ids, include: true
  attributes :id, :username, :won, :lost, :tied
  has_many :wallets
end
